//
//  ListViewController.m
//  GitHubRepos
//  Created by Juraj Hilje on 06/11/14.
//

#import "ListViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFURLResponseSerialization.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "UIImageView+AFNetworking.h"
#import "Repo.h"
#import "ListCell.h"
#import "DetailViewController.h"

#define k_JSON_URL @"https://api.github.com/users/mralexgray/repos"
#define k_VIEW_TITLE @"GitHub Repos"
#define k_ROW_HEIGHT 70

@interface ListViewController ()

@property (strong, nonatomic) NSMutableArray *repos;
@property (strong, nonatomic) Repo *selectedRepo;
@property BOOL loadJSONFlag;

- (void)loadJSONWithUrlString:(NSString *)url;
- (void)parseData:(id)responseObject;
- (void)refreshData;

@end

@implementation ListViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailViewFromList"])
    {
        DetailViewController *dvc = [segue destinationViewController];
        
        [dvc setTitle:self.selectedRepo.name];
        [dvc setWebURL:self.selectedRepo.htmlURL];
    }

}

#pragma mark - Load and parse JSON

- (void)refreshData
{
    [self loadJSONWithUrlString:k_JSON_URL];
}

- (void)loadJSONWithUrlString:(NSString *)url
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [self parseData:responseObject];
         
         [self setLoadJSONFlag:NO];
         
         [self.refreshControl endRefreshing];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         
         [self.refreshControl endRefreshing];
     }];
}

- (void)parseData:(id)responseObject
{
    [self setRepos:[NSMutableArray array]];
    
    for (id repo in responseObject)
    {
        Repo *tempRepo = [[Repo alloc] init];
        
        [tempRepo setFullName:repo[@"full_name"]];
        [tempRepo setName:repo[@"name"]];
        [tempRepo setHtmlURL:repo[@"html_url"]];
        [tempRepo setAvatarURL:repo[@"owner"][@"avatar_url"]];
        
        [self.repos addObject:tempRepo];
    }
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.repos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Repo *repo = self.repos[indexPath.row];
    
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell.titleLabel setText:repo.fullName];
    [cell.detailLabel setText:repo.htmlURL];
    [cell.thumbImageView setImageWithURL:[NSURL URLWithString:repo.avatarURL]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setSelectedRepo:self.repos[indexPath.row]];
    
    [self performSegueWithIdentifier:@"detailViewFromList" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return k_ROW_HEIGHT;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:k_VIEW_TITLE];
    
    [self.tableView setRowHeight:k_ROW_HEIGHT];
    
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    
    [self setLoadJSONFlag:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.loadJSONFlag)
    {
        [self refreshData];
    }
}

@end