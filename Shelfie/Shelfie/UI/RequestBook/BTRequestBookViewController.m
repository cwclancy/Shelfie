//
//  BTRequestBookViewController.m
//  Shelfie
//
//  Created by Claudia Haddad on 8/2/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTRequestBookViewController.h"
#import "BTBookAPIManager.h"


@interface BTRequestBookViewController ()

@property (strong, nonatomic) NSString *isbn;
@property (strong, nonatomic) IBOutlet UITextField *isbnField;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *sliderLabel;


@end

@implementation BTRequestBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void) textEntered {
//[[BTBookAPIManager shared] fetchBookWithIsbn:self.isbn completion:^(id book, NSError *error) {
 //   if (error) {
  //      NSLog(@"%@", error);
  //  } else {
   //     [self makeBook:book];
  //  }
//}
//

//}
 
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
