//
//  DetailViewController.m
//  GitHubRepos
//  Created by Juraj Hilje on 06/11/14.
//

#import "DetailViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface DetailViewController ()

- (void)loadHTML:(NSURL *)url;

@end

@implementation DetailViewController

#pragma mark - Load HTML

- (void)loadHTML:(NSURL *)url
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [self.webView loadHTMLString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] baseURL:url];
     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    
    [operation start];
}

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadHTML:[NSURL URLWithString:self.webURL]];
}

@end