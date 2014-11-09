//
//  Repo.h
//  GitHubRepos
//  Created by Juraj Hilje on 06/11/14.
//

#import <Foundation/Foundation.h>

@interface Repo : NSObject

@property (strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *htmlURL;
@property (strong, nonatomic) NSString *avatarURL;

@end