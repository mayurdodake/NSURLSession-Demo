//
//  GithubTableViewController.m
//  NSURLSession
//
//  Created by apple on 30/08/16.
//  Copyright © 2016 felix-its. All rights reserved.
//

#import "GithubTableViewController.h"
#import "Committer.h"


@interface GithubTableViewController ()

@end

@implementation GithubTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _committerarray=[[NSMutableArray alloc]init];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    NSString *url=@"https://api.github.com/repos/hadley/ggplot2/commits";
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task1=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        
        NSArray *resultarray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        
        for(NSDictionary *temdic in resultarray)
        {
            NSDictionary *commitdic=[temdic objectForKey:@"commit"];
            
            NSDictionary *committerdic=[commitdic objectForKey:@"committer"];
            
            Committer *obj=[[Committer alloc]init];
            
            obj.name=[committerdic objectForKey:@"name"];
            obj.email=[committerdic objectForKey:@"email"];
            obj.date=[committerdic objectForKey:@"date"];
            
            [_committerarray addObject:obj];
        }
        
        [self.tableView reloadData];
        
    }];
    
    [task1 resume];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return _committerarray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell=[cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    Committer *temp=[_committerarray objectAtIndex:indexPath.row];
    
    cell.textLabel.text=temp.name;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@  %@",temp.email,temp.date];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
