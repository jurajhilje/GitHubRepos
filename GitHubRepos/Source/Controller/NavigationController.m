//
//  NavigationController.m
//  GitHubRepos
//  Created by Juraj Hilje on 06/11/14.
//

#import "NavigationController.h"

#define k_TINT_COLOR [UIColor colorWithRed:133/255.0f green:0/255.0f blue:178/255.0f alpha:1]

@implementation NavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UINavigationBar appearance] setTintColor:k_TINT_COLOR];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]} forState:UIControlStateNormal];
    
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Light" size:20], NSForegroundColorAttributeName:k_TINT_COLOR}];
}


@end