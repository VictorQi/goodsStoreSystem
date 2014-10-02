//
//  checkListViewController.m
//  goodsManagementSystem
//
//  Created by victor on 14-9-26.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import "checkListViewController.h"

@interface checkListViewController ()
{
    LMContainsLMComboxScrollView *bgScrollView;
    NSMutableArray *listArray;
    NSMutableArray *listIdArray;
    listCheck *checkedList;
    NSMutableArray *titleArray;
    BOOL permissionA;
    NSInteger selectedListId;
    NSString *selectedListType;
    NSString *selectedListPrice;
    NSString *selectedListCount;
    NSString *selectedListName;
    NSString *selectedListInfo;
    NSString *selectedListCategory;
}
@end

@implementation checkListViewController
#define kDropDownListTag 1000

- (void)viewDidLoad {
    [super viewDidLoad];
    
    listArray = [[allDataControll shareSingleton]getUncheckedList:0];
    
    permissionA = NO;
    
    
    titleArray= [NSMutableArray arrayWithObjects:@"出货单",@"进货单", nil];
    if (listArray) {
        
        listIdArray = [[NSMutableArray alloc]init];
        for (listCheck *uncheck in listArray) {
            NSInteger x_id = uncheck.Id;
            //NSLog(@"goodsname is %@",uncheck.goodsName);
            [listIdArray addObject:[NSString stringWithFormat: @"%ld",x_id]];
            //NSLog(@"%ld",x_id);
        }
        listCheck *initList =[listArray firstObject];
        self.listName.text = initList.goodsName;
        self.listPrice.text = initList.Price;
        self.listCount.text = initList.Count;
        selectedListType = [titleArray firstObject];
        selectedListId = [[listIdArray firstObject]integerValue];
        selectedListCount = initList.Count ;
        selectedListPrice = initList.Price;
        selectedListName = initList.goodsName;
        selectedListInfo = initList.goodsInfo;
        selectedListCategory = initList.Category;
    }else{
        listIdArray = nil;
        self.listName.text = @"";
        self.listPrice.text = @"";
        self.listCount.text = @"";
    }
    NSLog(@"listArray has %ld items",[listIdArray count]);
    
    
    bgScrollView = [[LMContainsLMComboxScrollView alloc]initWithFrame:CGRectMake(0, 70, 320, 400)];
    bgScrollView.backgroundColor = [UIColor clearColor];
    bgScrollView.showsVerticalScrollIndicator = NO;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:bgScrollView];
    [self setUpBgScrollView];
    
    
    UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(194, 368, 20, 10)];
    [switchButton setOn:NO];
    [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    self.permissionSwitch = switchButton;
    [self.view addSubview:self.permissionSwitch];
    
    
    
    UIBarButtonItem *confirmButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"提交", @"")
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(confirm)];
    self.navigationItem.rightBarButtonItem = confirmButton;
    
    
    
    
    
    NSLog(@"selected list type is %@,selected list id is %ld",selectedListType,selectedListId);

    
}

- (void) confirm
{
    BOOL success = [[allDataControll shareSingleton]setPermissionByType:selectedListType
                                                              andListId:selectedListId
                                                            andListName:selectedListName
                                                               andCount:selectedListCount
                                                               andPrice:selectedListPrice
                                                            andCategoty:selectedListCategory
                                                                andInfo:selectedListInfo
                                                         withPermission:permissionA];
    NSString *message = success ? @"操作成功" : @"操作失败";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"仓储管理系统" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void) updateUI:(NSInteger)flag
{
    switch (flag) {
        case 0:
            self.staticCount.text = @"出货数：";
            self.staticCount.text = @"出货价格：";
            self.listName.text = @"";
            self.listCount.text = @"";
            //self.permissionSwitch.on = NO;
            listArray = [[allDataControll shareSingleton]getUncheckedList:flag];
            listIdArray = [[NSMutableArray alloc]init];
            for (listCheck *uncheck in listArray) {
                NSInteger x_1 = uncheck.Id;
                [listIdArray addObject:[NSString stringWithFormat:@"%ld",x_1]];
            }
            break;
         case 1:
            self.staticCount.text = @"进货数：";
            self.staticCount.text = @"进货价格：";
            self.listName.text = @"";
            self.listCount.text = @"";
            //self.permissionSwitch.on = NO;
            listArray = [[allDataControll shareSingleton]getUncheckedList:flag];
            listIdArray = [[NSMutableArray alloc]init];
            for (listCheck *uncheck in listArray) {
                NSInteger x_1 = uncheck.Id;
                [listIdArray addObject:[NSString stringWithFormat:@"%ld",x_1]];
            }
            break;
        default:
            break;
    }
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        permissionA = YES;
        NSLog(@"是");
    }else {
        permissionA = NO;
        NSLog( @"否");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setUpBgScrollView
{
    
    LMComBoxView *comBox_1 = [[LMComBoxView alloc]initWithFrame:CGRectMake(136, 8, 168,30)];
    comBox_1.backgroundColor = [UIColor whiteColor];
    comBox_1.arrowImgName = @"down_dark0.png";
    
    
    //NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:@"出货单",@"进货单", nil];
    comBox_1.titlesList = titleArray;
    comBox_1.delegate = self;
    comBox_1.supView = bgScrollView;
    [comBox_1 defaultSettings];
    comBox_1.tag = kDropDownListTag;
    [bgScrollView addSubview:comBox_1];
    
    LMComBoxView *comBox = [[LMComBoxView alloc]initWithFrame:CGRectMake(136, 68, 168,30)];
    comBox.backgroundColor = [UIColor whiteColor];
    comBox.arrowImgName = @"down_dark0.png";
    if (listIdArray) {
        comBox.titlesList = listIdArray;
    }else
    {
        comBox.titlesList = nil;
    }
    comBox.delegate = self;
    comBox.supView = bgScrollView;
    [comBox defaultSettings];
    comBox.tag = kDropDownListTag+1;
    [bgScrollView addSubview:comBox];
    
    
}




#pragma mark -LMComBoxViewDelegate
-(void)selectAtIndex:(int)index inCombox:(LMComBoxView *)_combox
{
    NSInteger tag = _combox.tag - kDropDownListTag;
    if (tag == 0) {
        //listArray = [[allDataControll shareSingleton]getUncheckedList:0];
        [self updateUI:index];
        selectedListType = [titleArray objectAtIndex:index];
        LMComBoxView *idCombox = (LMComBoxView *)[bgScrollView viewWithTag:tag + 1 + kDropDownListTag];
        idCombox.titlesList = listIdArray;
        [idCombox reloadData];
        NSLog(@"list Id num is %ld",[listIdArray count]);
    }else if(tag == 1)
    {
        listCheck *UnCheckedList = [[listCheck alloc]init];
        UnCheckedList =[listArray objectAtIndex:index];
        self.listName.text = UnCheckedList.goodsName;
        self.listPrice.text = UnCheckedList.Price;
        self.listCount.text = UnCheckedList.Count;
        
        selectedListId = index+1;
        selectedListCount = UnCheckedList.Count;
        selectedListPrice = UnCheckedList.Price;
        selectedListName = UnCheckedList.goodsName;
        selectedListInfo = UnCheckedList.goodsInfo;
        selectedListCategory = UnCheckedList.Category;
    }
    
    NSLog(@"selected list type is %@,selected list id is %ld",selectedListType,selectedListId);
}





@end
