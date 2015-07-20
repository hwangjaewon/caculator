//
//  ViewController.h
//  example4
//
//  Created by smart on 15. 5. 15..
//  Copyright (c) 2015년 smartmobile leehyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalcEngine.h"
@class CalcEngine;

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
//property 지시어는 getter와 setter에 대한 코드를 자동으로 생성해줌! 와 좋다.
@property (weak,nonatomic)IBOutlet UILabel *display;
@property (nonatomic) BOOL isEditing; //숫자 입력의 초기화 여부 판단한다.
@property (nonatomic) BOOL isFirstOperator;
@property (strong, nonatomic) IBOutlet UITableView *resultTableView;//테이블에 결과를 누적시킨다.
@property (strong, nonatomic) NSMutableArray *cumulative_result; //expression 결과값을 배열로 누적시킨다.
//@property (nonatomic, strong) CalcEngine *brain; - 카테고리를 사용하지 않을 경우, 엔진을 이 곳에 프로퍼티한다.
@end
