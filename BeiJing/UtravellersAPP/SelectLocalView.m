//
//  SelectLocalView.m
//  TourismApp
//
//
#import "SelectLocalView.h"
#define FirstComponent 0
#define SubComponent 1
#define ThirdComponent 2
@interface SelectLocalView ()
@property (nonatomic, retain) NSDictionary *dict;
@property (nonatomic, retain) NSArray *pickerArray;
@property (nonatomic, retain) NSArray *subPickerArray;
@property (nonatomic, retain) NSArray *thirdPickerArray;
@property (nonatomic, retain) NSArray *selectArray;
@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;
@property (weak, nonatomic) IBOutlet UIView *topView;
- (IBAction)close:(id)sender;
- (IBAction)submitAction:(id)sender;
@end
@implementation SelectLocalView
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    _topView.layer.borderWidth = 1.0;
//    _topView.layer.borderColor = [[UIColor colorWithRed:231.0 / 255 green:231.0 / 255 blue:231.0 / 255 alpha:1.0] CGColor];
    
    
	NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
	_dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    if (self.province == nil) {
        self.pickerArray = [_dict allKeys];
    }else{
        if (self.city == nil) {

            self.selectArray = [_dict objectForKey:_province];
            if ([_selectArray count] > 0) {
                self.pickerArray = [[self.selectArray objectAtIndex:0] allKeys];
            }
        
        }else{
            self.selectArray = [_dict objectForKey:_province];
            if ([_selectArray count] > 0) {
                self.subPickerArray = [[self.selectArray objectAtIndex:0] allKeys];
                
                if ([_subPickerArray count] > 0) {
                    self.pickerArray = [[self.selectArray objectAtIndex:0] objectForKey:_city];
                }
            }
            
        }
        
    }
    
//	self.selectArray = [_dict objectForKey:[[_dict allKeys] objectAtIndex:0]];
//	if ([_selectArray count] > 0) {
//		self.subPickerArray = [[self.selectArray objectAtIndex:0] allKeys];
//	}
//	if ([_subPickerArray count] > 0) {
//		self.thirdPickerArray = [[self.selectArray objectAtIndex:0] objectForKey:[self.subPickerArray objectAtIndex:0]];
//	}
}

#pragma mark --
#pragma mark--UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if (component == FirstComponent) {
		return [self.pickerArray count];
	}
//	if (component == SubComponent) {
//		return [self.subPickerArray count];
//	}
//	if (component == ThirdComponent) {
//		return [self.thirdPickerArray count];
//	}
	return 0;
}

#pragma mark--
#pragma mark--UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (component == FirstComponent) {
		return [self.pickerArray objectAtIndex:row];
	}
//	if (component == SubComponent) {
//		return [self.subPickerArray objectAtIndex:row];
//	}
//	if (component == ThirdComponent) {
//		return [self.thirdPickerArray objectAtIndex:row];
//	}
	return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	//NSLog(@"row is %d,Component is %d", row, component);
	if (component == 0) {
//		self.selectArray = [_dict objectForKey:[self.pickerArray objectAtIndex:row]];
//		if ([self.selectArray count] > 0) {
//			self.subPickerArray = [[self.selectArray objectAtIndex:0] allKeys];
//		}
//		else {
//			self.subPickerArray = nil;
//		}
//		if ([self.subPickerArray count] > 0) {
//			self.thirdPickerArray = [[self.selectArray objectAtIndex:0] objectForKey:[self.subPickerArray objectAtIndex:0]];
//		}
//		else {
//			self.thirdPickerArray = nil;
//		}
//		[pickerView selectedRowInComponent:1];
//		[pickerView reloadComponent:1];
		
	}
	if (component == 1) {
//		if ([_selectArray count] > 0 && [_subPickerArray count] > 0) {
//			self.thirdPickerArray = [[self.selectArray objectAtIndex:0] objectForKey:[self.subPickerArray objectAtIndex:row]];
//		}
//		else {
//			self.thirdPickerArray = nil;
//		}
		
	}
	//[pickerView reloadComponent:2];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
	UILabel *myView = nil;
    CGRect size = [[UIScreen mainScreen] bounds];
	NSArray *a = nil;
	if (component == FirstComponent) {
		a = self.pickerArray;
	}
//	if (component == SubComponent) {
//		a = self.subPickerArray;
//	}
//	if (component == ThirdComponent) {
//		a = self.thirdPickerArray;
//	}
	if (component == 0) {
		myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, size.size.width - 160, 30)];
		myView.textAlignment = UITextAlignmentCenter;
		myView.text = [a objectAtIndex:row];
		myView.font = [UIFont systemFontOfSize:14];         //用label来设置字体大小
		myView.backgroundColor = [UIColor clearColor];
	}
//	else {
//		myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 180, 30)];
//		myView.text = [a objectAtIndex:row];
//		myView.textAlignment = UITextAlignmentCenter;
//		myView.font = [UIFont systemFontOfSize:14];
//		myView.backgroundColor = [UIColor clearColor];
//	}
	return myView;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGRect size = [[UIScreen mainScreen] bounds];
	if (component == FirstComponent) {
		return size.size.width - 160;
	}
//	if (component == SubComponent) {
//		return 120.0;
//	}
//	if (component == ThirdComponent) {
//		return 100.0;
//	}
	return 0;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
   #pragma mark - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   }
 */
- (IBAction)close:(id)sender {
	[self.view removeFromSuperview];
}

- (IBAction)submitAction:(id)sender {
	
	NSInteger rows1 =  [_myPickerView selectedRowInComponent:0];
	
	NSString *s1 = [self.pickerArray objectAtIndex:rows1];
	
	[_delegate selectArea:s1];
	[self.view removeFromSuperview];
}

@end
