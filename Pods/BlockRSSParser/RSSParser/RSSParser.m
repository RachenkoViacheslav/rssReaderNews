//
//  RSSParser.m
//  RSSParser
//
//  Created by Thibaut LE LEVIER on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSParser.h"

#import "AFHTTPRequestOperation.h"
#import "AFURLResponseSerialization.h"

@implementation RSSParser

#pragma mark lifecycle
- (id)init {
    self = [super init];
    if (self) {
        items = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark -

#pragma mark parser

+ (void)parseRSSFeedForRequest:(NSURLRequest *)urlRequest
                       success:(void (^)(NSArray *feedItems))success
                       failure:(void (^)(NSError *error))failure
{
    RSSParser *parser = [[RSSParser alloc] init];
    [parser parseRSSFeedForRequest:urlRequest success:success failure:failure];
}


- (void)parseRSSFeedForRequest:(NSURLRequest *)urlRequest
                                          success:(void (^)(NSArray *feedItems))success
                                          failure:(void (^)(NSError *error))failure
{
    
    block = [success copy];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    
    operation.responseSerializer = [[AFXMLParserResponseSerializer alloc] init];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"application/rss+xml", @"application/atom+xml", nil];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        failblock = [failure copy];
        [(NSXMLParser *)responseObject setDelegate:self];
        [(NSXMLParser *)responseObject parse];
    }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         failure(error);
                                     }];
    
    [operation start];
    
}

#pragma mark -
#pragma mark NSXMLParser delegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"item"] || [elementName isEqualToString:@"entry"]) {
        currentItem = [[RSSItem alloc] init];
    }
    
    tmpString = [[NSMutableString alloc] init];
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{    
    if ([elementName isEqualToString:@"item"] || [elementName isEqualToString:@"entry"]) {
        [items addObject:currentItem];
    }
    if (currentItem != nil && tmpString != nil) {
        
        if ([elementName isEqualToString:@"title"]) {
            [currentItem setTitle:tmpString];
        }
        
        if ([elementName isEqualToString:@"author"]) {
            [currentItem setAuthor:tmpString];
        }
        
        if ([elementName isEqualToString:@"description"]) {
            [currentItem setItemDescription:tmpString];
        }
        
        if ([elementName isEqualToString:@"content:encoded"] || [elementName isEqualToString:@"content"]) {
            [currentItem setContent:tmpString];
        }
        
        if ([elementName isEqualToString:@"link"]) {
            [currentItem setLink:[NSURL URLWithString:tmpString]];
        }
        
        if ([elementName isEqualToString:@"comments"]) {
            [currentItem setCommentsLink:[NSURL URLWithString:tmpString]];
        }
        
        if ([elementName isEqualToString:@"wfw:commentRss"]) {
            [currentItem setCommentsFeed:[NSURL URLWithString:tmpString]];
        }
        
        if ([elementName isEqualToString:@"slash:comments"]) {
            [currentItem setCommentsCount:[NSNumber numberWithInt:[tmpString intValue]]];
        }
        
        if ([elementName isEqualToString:@"pubDate"]) {
            
          //пример строки "Thu, 7 May 2015 05:00:00 EDT"
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            NSString *dateString = tmpString;
            NSString *newString = [dateString substringToIndex:[dateString length]-3];
            
            [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
            
           
          
            [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss"];
            
            NSDate *newData = [formatter dateFromString:newString];
            
            NSLog(@"pub data = %@", newData );
            [currentItem setPubDate:newData];
        }

        if ([elementName isEqualToString:@"dc:creator"]) {
            [currentItem setAuthor:tmpString];
        }
        
        if ([elementName isEqualToString:@"guid"]) {
            [currentItem setGuid:tmpString];
        }
    }
    
    if ([elementName isEqualToString:@"rss"] || [elementName isEqualToString:@"feed"]) {
        block(items);
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [tmpString appendString:string];
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    failblock(parseError);
    [parser abortParsing];
}

#pragma mark -

@end
