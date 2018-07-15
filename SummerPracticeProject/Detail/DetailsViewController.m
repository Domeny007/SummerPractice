//
//  DetailsViewController.m
//  SummerPracticeProject
//
//  Created by Азат Алекбаев on 15/07/2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

#import "DetailsViewController.h"
#import "TextTableViewCell.h"
#import "AttachTableViewCell.h"
#import "UIKit+AFNetworking.h"
#import "Constants.h"

@interface DetailsViewController ()

@property (retain, nonatomic) IBOutlet UILabel *newsDateTime;
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DetailsViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.newsDateTime.text = self.item.formatedDate;
    
    self.tableView.estimatedRowHeight = 54;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone; 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.item.attachments.count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        // текст
        TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TEXT_CELL forIndexPath:indexPath];
        cell.text.scrollEnabled = ([self.item.text isEqualToString:@""]) ? YES : NO;
        cell.text.text = self.item.text;
        return cell;
    }
    // вложения
    Attachment *attach = self.item.attachments[indexPath.row - 1];
    AttachTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ATTACH_CELL forIndexPath:indexPath];
    cell.photoView.image = nil;
    if (attach.imageURLString) {
        
        // загрузка фото с отложенным отображением в ячейке
        NSURL *url = [NSURL URLWithString:attach.imageURLString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        __weak AttachTableViewCell *weakCell = cell;
        __weak UITableView *weakTableView = tableView;
        [cell.photoView setImageWithURLRequest:request placeholderImage:nil
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           weakCell.photoView.image = image;
                                           if ([weakTableView.visibleCells containsObject:weakCell]) {
                                               [weakTableView reloadRowsAtIndexPaths:@[ indexPath ]
                                                                    withRowAnimation:UITableViewRowAnimationNone];
                                           }
                                       } failure:nil];
    }
    cell.titleTextView.scrollEnabled = ([attach.title isEqualToString:@""]) ? YES : NO;
    cell.titleTextView.text = attach.title;
    
    cell.backView.backgroundColor = ([attach.type isEqualToString:@"photo"]) ? [UIColor whiteColor]: ATTACH_COLOR;
    if ([attach.type isEqualToString:@"photo"] || [attach.type isEqualToString:@"link"]) {
        cell.typeLabel.text = nil;
    } else {
        cell.typeLabel.text = [NSString stringWithFormat:@"[неподдерживаемый контент: %@]", attach.type];
    }
    return cell;
}
- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
