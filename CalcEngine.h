//
//  CalcEngine.h
//  example4
//
//  계산을 담당하는 엔진.
//  1. 엔진에는 큐가 존재해서 입력된 계산값들을 하나씩 들어간 순서대로 뽑을 수 있다.
//  2. 계산기에서 숫자입력이 끝나면 (연산자, 등호버튼을 누르면) 숫자를 이 큐에 집어넣는다. 그리고 연산의 종류를 엔진에게 알려준다.
//  3. 또 숫자를 입력하고 . . . 반복
//  4. 등호나, 다른 연산자를 누르면 앞 선 2개 이상의 숫자가 저장된다.
//    특히 등호를 누르면 엔진은 저장된 2개의 숫자를 순서대로 꺼내어 엔진이 알고있는 연산 종류에 맞게 계산하여 그 결과를 출력한다.
//  Created by smart on 15. 5. 15..
//  Copyright (c) 2015년 smartmobile leehyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalcEngine : NSObject
+ (id)sharedEngine;
-(void)pushOperand:(NSString *)anOperand; //숫자값을 집어넣는다.
-(void)pushOperator:(NSString *)anOperator; //연산자를 집어넣어 어떤 연산을 할 것인지 설정한다.
-(double)performOperation; //들어있는 숫자값들과 연산자로 계산하고 결과를 출력한다.
-(void)removeAll;
@end
