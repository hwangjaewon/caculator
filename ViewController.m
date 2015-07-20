//
//  ViewController.m
//  example4
//
//  Created by smart on 15. 5. 15..
//  Copyright (c) 2015년 smartmobile leehyo. All rights reserved.
//

#import "ViewController.h"
#import "CalcEngine.h"
static double result = 0.0;
static NSString *cumulativeResult = @""; //테이블에 누적시키기 위한 한 개의 expression 식을 저장한다.

@interface ViewController ()
@property (strong, nonatomic) CalcEngine *brain;//CalcEngine의 인스턴스를 새 프로퍼티로 추가한다.(카테고리)
@end



@implementation ViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.cumulative_result = [[NSMutableArray alloc]initWithCapacity:0];
}

//연산자 클릭 시 현재 연산이 무엇인지 brain에게 알려줘야 함. 또한 그 전에 입력 숫자를 brain에게 밀어넣어줘야 한다.
//숫자를 밀어넣은 후 입력 여부의 flag인 isEditing을 NO 로 다시 초기화한다.
// 이 작업은 각 연산자를 누를때, '=' 버튼을 누를때에 발생하므로 따로 함수정의한다.
-(void)enterDigit{
    NSLog(@"enterDigit in ");
    [[CalcEngine sharedEngine] pushOperand:self.display.text];
    //[self.brain pushOperand:self.display.text];
    self.isEditing = NO;
}

//숫자 클릭 이벤트
- (IBAction)digitPressed:(UIButton *)sender {
    cumulativeResult = [cumulativeResult stringByAppendingString:[sender currentTitle]];
    NSLog(@"digitPressed in  : %@ ",[sender currentTitle]);
    if(self.isEditing)
        self.display.text = [self.display.text stringByAppendingString:sender.currentTitle];
    else{
        self.display.text = sender.currentTitle;
        self.isEditing = YES;
    }
    
}


//연산자 클릭 이벤트
- (IBAction)operatorPressed:(UIButton *)sender {
    cumulativeResult = [cumulativeResult stringByAppendingString:[sender currentTitle]];
    NSLog(@"operatorPressed in : %@, isFirstOperator is %d ",
          [sender currentTitle],self.isFirstOperator);
    
    [self enterDigit]; //이전 숫자를 큐에 넣어줌.
    
    if(self.isFirstOperator == NO) {// 처음 푸쉬하는 연산자라면, 계산기능 수행하지 않고 푸쉬만 한다.
        NSLog(@"First!! operatorPressed in  : %d",self.isFirstOperator);
        [[CalcEngine sharedEngine] pushOperator:sender.currentTitle];
        self.isFirstOperator = YES;
    }
    else{ //두번째 이상의 연산자라면 바로바로 계산하며 넘어간다.
        NSLog(@"NOT First!! operatorPressed in  : %d",self.isFirstOperator);
        result = [[CalcEngine sharedEngine] performOperation];
        NSString *result_toString = [NSString stringWithFormat:@"%e", result];
        NSLog(@"operatorPressed in , result is : %@",result_toString);
        [[CalcEngine sharedEngine] pushOperator:sender.currentTitle];
        
        //double -> NSString  형 변환 하여 계산결과값 큐에 넣어준다.
        [[CalcEngine sharedEngine] pushOperand:result_toString];
    }
    //[self.brain pushOperator:sender.currentTitle]; 싱글톤이 아닌 코드버전이다.
    self.display.text = [self.display.text stringByAppendingString:sender.currentTitle];
}

//excute(calc) 클릭 이벤트
- (IBAction)excute:(UIButton *)sender {
    cumulativeResult = [cumulativeResult stringByAppendingString:[sender currentTitle]];
    [self enterDigit];
    //self.display.text = [NSString stringWithFormat:@"%f", [self.brain performOperation]];
    result = [[CalcEngine sharedEngine] performOperation];
    self.display.text = [NSString stringWithFormat:@"%f", result];
    
    cumulativeResult =
    [cumulativeResult stringByAppendingString:[NSString stringWithFormat:@"%2f", result]];
    
    //테이블 뷰에 보여줄 데이터소스를 저장한다. (expression 한 줄 저장)
    [self.cumulative_result addObject:cumulativeResult];
    NSLog(@"excute in ! and cumulativeResult is %@",self.cumulative_result);
    cumulativeResult = @"";
    [self.resultTableView reloadData];
    
    self.display.text = @"0";
    self.isEditing = NO;
    self.isFirstOperator = NO;
    [[CalcEngine sharedEngine] removeAll];
}

//clear 클릭 이벤트
- (IBAction)clear:(UIButton *)sender {
    NSLog(@"clear in");
    self.display.text = @"0";
    self.isEditing = NO;
    self.isFirstOperator = NO;
    [[CalcEngine sharedEngine] removeAll];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cumulative_result count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    //Configure(display) the cell
    cell.textLabel.text = [self.cumulative_result objectAtIndex:[indexPath row]];
    
    return cell;
}


@end
