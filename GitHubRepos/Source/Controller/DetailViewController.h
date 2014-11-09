//
//  DetailViewController.h
//  GitHubRepos
//  Created by Juraj Hilje on 06/11/14.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *webURL;

@end