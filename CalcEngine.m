//
//  CalcEngine.m
//  example4
//
//  Created by smart on 15. 5. 15..
//  Copyright (c) 2015년 smartmobile leehyo. All rights reserved.
//

#import "CalcEngine.h"
//각 단어를 0,1,2,3 에 매칭하기 위해 정의한다. 숫자값으로 0 일때는 덧셈 . . . 열거형으로 enum 지정.
enum {plus, minus, multiply, divide};

@interface CalcEngine()
@property (strong,nonatomic) NSMutableArray *operandQueue;
@property (assign) int operator;
//@property (assign) double *result;
@end



@implementation CalcEngine

double result = 0.0;

//싱글톤 객체를 반환
static CalcEngine *en;
+ (id)sharedEngine{
    if (en == nil) {
        //처음 호출이므로 메모리에 생성, 할당
        en = [[CalcEngine alloc] init];
    }
    return en;
}



-(NSMutableArray *)operandQueue
{
    if(!_operandQueue){
        _operandQueue = [NSMutableArray array];
        [_operandQueue removeAllObjects];
        
    }
    return _operandQueue;
}

-(void)pushOperand:(NSString *)anOperand //숫자값을 집어넣는다.
{
    NSLog(@"pushOperand in (숫자값 넣기), result is %@", anOperand);
    [self.operandQueue addObject:anOperand];
}

-(void)pushOperator:(NSString *)anOperator //연산자를 집어넣어 어떤 연산을 할 것인지 설정한다.
{
    NSLog(@"pushOperator in");
    if([anOperator isEqualToString:@"+"]){
        self.operator = plus;
        NSLog(@"pushOperator in (연산자 set plus)");
    }
    else if([anOperator isEqualToString:@"-"]){
        NSLog(@"pushOperator in (연산자 set minus)");
        self.operator = minus;
    }
    else if([anOperator isEqualToString:@"*"]){
        NSLog(@"pushOperator in (연산자 set multiply)");
        self.operator = multiply;
    }
    else{
        NSLog(@"pushOperator in (연산자 set divide)");
        self.operator = divide;
    }
}

-(double)popOutOfQueue //큐로부터 값을 하나씩 빼오는 부분. NSString으로 숫자들이 들어있으니, 이를 하나씩 빼온다.
{
    
    double result_return = 0.0;
    NSLog(@"popOutOfQueue (값 빼기) in, 기존 Queue is : %@" , self.operandQueue);
    
    id front = [self.operandQueue objectAtIndex:0];
    
    if(front)
        [self.operandQueue removeObjectAtIndex:0];
    
    if([front respondsToSelector:@selector(doubleValue)])
        result_return = [front doubleValue];
    
    NSLog(@"popOutOfQueue (값 빼기), 빼는 result is : %f" , result_return);
    return result_return;
}


-(double)performOperation
{
    NSLog(@"perfromOperation in ");
    switch(self.operator){
        case plus :
            result = [self popOutOfQueue] + [self popOutOfQueue];
            NSLog(@"pushOperator in plus, result is %f", result);
            break;
        case minus :
            result = [self popOutOfQueue] - [self popOutOfQueue];
            NSLog(@"pushOperator in minus, result is %f", result);
            break;
        case multiply :
            result = [self popOutOfQueue] * [self popOutOfQueue];
            break;
        case divide:
            result = [self popOutOfQueue] / [self popOutOfQueue];
            break;
    }
    return result;
}

-(void)removeAll
{
    [self.operandQueue removeAllObjects];
    NSLog(@"removeAll (값 리셋) in, 기존 Queue is : %@" , self.operandQueue);
}
@end
