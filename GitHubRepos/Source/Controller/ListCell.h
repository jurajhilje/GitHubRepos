//
//  ListCell.h
//  GitHubRepos
//  Created by Juraj Hilje on 06/11/14.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;

@end