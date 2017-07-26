//
//  ViewController.m
//  SDKProject
//
//  Created by wwp on 2017/7/13.
//  Copyright © 2017年 wwp. All rights reserved.
//

#import "ViewController.h"
#import <HYBaseF/SDevice.h>
#import <HYBaseF/UIDevice+Extension.h>
#import "HWGet.h"
#import <HYBaseF/HWGetAddressBook.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "CityData.h"


@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *_name;
    
}
@property (nonatomic,strong) CBCentralManager *cmgr; //中心管理者

@property (nonatomic,strong) CBPeripheral *peripheral;


@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;

@property (nonatomic,strong) UITableView *listTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic, copy) void (^block)(void);
@property (nonatomic, copy) NSString *name;

@end

@implementation ViewController
//@dynamic name;//系统不自动生成set get方法 需要自己手动生成
//@synthesize name=_nickName;
@synthesize name;


-(UITableView *)listTableView
{
    if (!_listTableView) {
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        tableView.delegate=self;
        tableView.dataSource=self;
        _listTableView = tableView;
    }
    return _listTableView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    hwSaveCache = [HWGet new];
    // device 环境
    hwSaveCache.device = [self deviceInit];
    NSLog(@"000000-----------**%@",hwSaveCache.device.appTimeZone);
    [self.cmgr isScanning];
//    [self.cmgr scanForPeripheralsWithServices:nil options:nil];
    [self.view addSubview:self.listTableView];
    [self initData];
   __block int an = 43;

    void (^testBlock)(NSString *str)= ^(NSString *str){
        NSLog(@"anitn---%d",an);
        
    };
    an = 60;
    
    testBlock(@"abc");
    

    __weak typeof(self) weakSelf = self;
    self.block = ^{
//        __strong所起的作用就是在抢占的时候strongSelf还是非nil的，避免出现nil的情况
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf doSomething]; // strongSelf != nil
        // 在抢占的时候，strongSelf还是非nil的。
        [strongSelf doAnotherThing];
    };
/*
 在block不是作为一个property的时候，可以在block里面直接使用self，比如UIView的animation动画block。
 当block被声明为一个property的时候，需要在block里面使用weakSelf，来解决循环引用的问题。
 当和并发执行相关的时候，当涉及异步的服务的时候，block可以在之后被执行，并且不会发生关于self是否存在的问题。
 */
//    self.name=@"abc";
//    NSLog(@"name---%@---%@---%@",_name,_nickName,self.name);
    
}
-(void)doSomething
{
    
}
-(void)doAnotherThing
{
    
}
-(void)initData
{
    NSArray *netData = @[
                         @{
                             @"text":@"河北省",
                             @"level":@"0",
                             @"submodels":@[
                                     @{
                                         @"text":@"衡水市",
                                         @"level":@"1",
                                         @"submodels":@[
                                                 @{
                                                     @"text":@"阜城县",
                                                     @"level":@"2",
                                                     @"submodels":@[
                                                             @{
                                                                 @"text":@"大白乡",
                                                                 @"level":@"3",
                                                                 },
                                                             @{
                                                                 @"text":@"建桥乡",
                                                                 @"level":@"3",
                                                                 },
                                                             @{
                                                                 @"text":@"古城镇",
                                                                 @"level":@"3",
                                                                 }
                                                             ]
                                                     },
                                                 @{
                                                     @"text":@"武邑县",
                                                     @"level":@"2",
                                                     },
                                                 @{
                                                     @"text":@"景县",
                                                     @"level":@"2",
                                                     }
                                                 ]
                                         },
                                     @{
                                         @"text":@"廊坊市",
                                         @"level":@"1",
                                         @"submodels":@[
                                                 @{
                                                     @"text":@"固安县",
                                                     @"level":@"2",
                                                     },
                                                 @{
                                                     @"text":@"三河市",
                                                     @"level":@"2",
                                                     },
                                                 @{
                                                     @"text":@"霸州市",
                                                     @"level":@"2",
                                                     }
                                                 ]
                                         }
                                     ]
                             },
                         @{
                             @"text":@"山东省",
                             @"level":@"0",
                             @"submodels":@[
                                     @{
                                         @"text":@"德州市",
                                         @"level":@"1",
                                         @"submodels":@[
                                                 @{
                                                     @"text":@"临邑县",
                                                     @"level":@"2",
                                                     },
                                                 @{
                                                     @"text":@"齐河县",
                                                     @"level":@"2",
                                                     },
                                                 @{
                                                     @"text":@"平原县",
                                                     @"level":@"2",
                                                     }
                                                 ]
                                         },
                                     @{
                                         @"text":@"烟台市",
                                         @"level":@"1",
                                         @"submodels":@[
                                                 @{
                                                     @"text":@"蓬莱市",
                                                     @"level":@"2",
                                                     },
                                                 @{
                                                     @"text":@"招远市",
                                                     @"level":@"2",
                                                     },
                                                 @{
                                                     @"text":@"海阳市",
                                                     @"level":@"2",
                                                     }
                                                 ]
                                         }
                                     ]
                             },
                         ];
    self.dataArray = [NSMutableArray new];
    for (int i = 0; i < netData.count; i++) {
        CityData *foldCellModel = [CityData modelWithDic:(NSDictionary *)netData[i]];
        [self.dataArray addObject:foldCellModel];
    }
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    CityData *foldCellModel = self.dataArray[indexPath.row];
    cell.textLabel.text = foldCellModel.text;
    
    return cell;
}
//UITableViewCell的缩进
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityData *foldCellModel = self.dataArray[indexPath.row];
    return foldCellModel.level.intValue;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CityData *didSelectFoldCellModel = self.dataArray[indexPath.row];
    
    [tableView beginUpdates];
    //将点开的cell加入到listtabviewcell中
    if (didSelectFoldCellModel.belowCount == 0) {
        
        //Data
        NSArray *submodels = [didSelectFoldCellModel open];
        NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:((NSRange){indexPath.row + 1,submodels.count})];
        [self.dataArray insertObjects:submodels atIndexes:indexes];
        
        //Rows
        NSMutableArray *indexPaths = [NSMutableArray new];
        for (int i = 0; i < submodels.count; i++) {
            NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1 + i) inSection:indexPath.section];
            [indexPaths addObject:insertIndexPath];
        }
        [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        
    }else {
        
        //Data
        NSArray *submodels = [self.dataArray subarrayWithRange:((NSRange){indexPath.row + 1,didSelectFoldCellModel.belowCount})];
        [didSelectFoldCellModel closeWithSubmodels:submodels];
        [self.dataArray removeObjectsInArray:submodels];
        
        //Rows
        NSMutableArray *indexPaths = [NSMutableArray new];
        for (int i = 0; i < submodels.count; i++) {
            NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1 + i) inSection:indexPath.section];
            [indexPaths addObject:insertIndexPath];
        }
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
    [tableView endUpdates];
}

-(void)getFramework
{
    if (!hwGetAddressBook) {
        hwGetAddressBook = [[HWGetAddressBook  alloc]init];
    }
    __weak typeof(self) weakSelf = self;
    hwGetAddressBook.target=self;
    [hwGetAddressBook gainAddressBookInfoCompleteBlock:^(NSArray *allInfoArray, NSArray *chooseInfoArray, AddressBookInfoSuccessType successType, SBaseHandlerReturnType returnType) {
        switch (returnType) {
            case SBaseHandlerReturnTypeSuccess:
            {
                switch (successType) {
                    case addressBookInfoAllPeopleType:
                    {
                        // 上传所有信息回调 do somethiing
                    } break;
                    case addressBookInfochoosePeopleType:{
                        //选择了单个联系人后 do somethiing
                    }break;
                        
                    default:
                        break;
                }
            } break;
            case SBaseHandlerReturnTypeFailed:{
                //获取通讯录失败,回调 doSomething   .
            }break;
            default:
                break;
        }
    }];
    [hwGetAddressBook getUserAddressBookMessage];
}
-(SDevice *)deviceInit{
    SDevice *device = [[SDevice alloc]init];
    device.osCode = @"ios";
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    device.appVersionCode = [infoDic objectForKey:@"CFBundleShortVersionString"];
    device.appName = [infoDic objectForKey:@"CFBundleDisplayName"];
    device.appCode = [infoDic objectForKey:@"CFBundleIdentifier"];
    device.osVersion = [[UIDevice currentDevice]systemVersion];
    device.osName = [[UIDevice currentDevice]systemName];
    device.appLanguage =  [(NSDictionary*)[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    device.appCountry =  [(NSDictionary*)[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    device.model = [UIDevice model];
    device.isJailBroke = [UIDevice isJailBrokeDevice];
    //获取本地系统时区  可修改
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    NSLog(@"localTimeZone is -->%@",localTimeZone.name);
    device.appTimeZone = localTimeZone.name;
    //获取系统时区 不可修改
    //    NSTimeZone *systemTimeZone = [NSTimeZone systemTimeZone];
    //    NSLog(@"systemTimeZone -->%@",systemTimeZone.name);
    //
    //    NSTimeZone *defaultTimeZone = [NSTimeZone defaultTimeZone];
    //    NSLog(@"defaultTimeZone -->%@", defaultTimeZone.name);
    
    return device;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//将传入的NSString类型转换成NSData并返回
- (NSData*)dataWithHexstring:(NSString *)hexstring{
    NSData* aData;
    return aData = [hexstring dataUsingEncoding: NSASCIIStringEncoding];
}

//1.建立一个central manager 实例进行蓝牙管理
-(CBCentralManager *)cmgr
{
    if (!_cmgr) {
        _cmgr = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    }
    return _cmgr;
}
//只要中心管理者初始化 就会触发代理方法 判断蓝牙状态
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case 0:
            NSLog(@"CBCentralManagerStateUnknown");
            break;
        case 1:
            NSLog(@"CBCentralManagerStateResetting");
            break;
        case 2:
            NSLog(@"CBCentralManagerStateUnsupported");//不支持蓝牙
            break;
        case 3:
            NSLog(@"CBCentralManagerStateUnauthorized");
            break;
        case 4:
        {
            NSLog(@"CBCentralManagerStatePoweredOff");//蓝牙未开启
        }
            break;
        case 5:
        {
            NSLog(@"CBCentralManagerStatePoweredOn");//蓝牙已开启
            // 在中心管理者成功开启后再进行一些操作
            // 搜索外设
            [self.cmgr scanForPeripheralsWithServices:nil // 通过某些服务筛选外设
                                              options:nil]; // dict,条件
            // 搜索成功之后,会调用我们找到外设的代理方法
            // - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI; //找到外设
        }
            break;
        default:
            break;
    }
}
//2. 搜索外围设备
-(void)centralManager:(CBCentralManager *)central
didDiscoverPeripheral:(CBPeripheral *)peripheral
    advertisementData:(NSDictionary<NSString *,id> *)advertisementData
                 RSSI:(NSNumber *)RSSI
{
    NSLog(@"%s, line = %d, cetral = %@,peripheral = %@, advertisementData = %@, RSSI = %@", __FUNCTION__, __LINE__, central, peripheral, advertisementData, RSSI);
    // 需要对连接到的外设进行过滤
    // 1.信号强度(40以上才连接, 80以上连接)
    // 2.通过设备名(设备字符串前缀是 OBand)
    // 在此时我们的过滤规则是:有OBand前缀并且信号强度大于35
    // 通过打印,我们知道RSSI一般是带-的 当前外设的信号强度 单位 dbm
    //[peripheral.name hasPrefix:@"hywin"]||[peripheral.name hasPrefix:@"wwp"])
    if ([peripheral.name containsString:@"Band"] ) {
        // 在此处对我们的 advertisementData(外设携带的广播数据) 进行一些处理
        
        // 通常通过过滤,我们会得到一些外设,然后将外设储存到我们的可变数组中,
        // 这里由于附近只有1个运动手环, 所以我们先按1个外设进行处理
        
        // 标记我们的外设,让他的生命周期 = vc
        self.peripheral = peripheral;
        // 发现完之后就是进行连接
        [self.cmgr connectPeripheral:self.peripheral options:nil];
        NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
    }
}
//3.连接外围设备
// 中心管理者连接外设成功
- (void)centralManager:(CBCentralManager *)central // 中心管理者
  didConnectPeripheral:(CBPeripheral *)peripheral // 外设
{
    NSLog(@"已经连接到了 %s, line = %d, %@=连接成功", __FUNCTION__, __LINE__, peripheral.name);
    // 连接成功之后,可以进行服务和特征的发现
    
    //  设置外设的代理
    self.peripheral.delegate = self;
    // 外设发现服务,传nil代表不过滤
    // 这里会触发外设的代理方法 - (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
    [self.peripheral discoverServices:nil];
    
    [central stopScan];
    
}
// 外设连接失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%s, line = %d, %@=连接失败", __FUNCTION__, __LINE__, peripheral.name);
    
}

// 丢失连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%s, line = %d, %@=断开连接", __FUNCTION__, __LINE__, peripheral.name);
}
//4.获得外围设备的服务 & 5.获得服务的特征

// 发现外设服务里的特征的时候调用的代理方法(这个是比较重要的方法，你在这里可以通过事先知道UUID找到你需要的特征，订阅特征，或者这里写入数据给特征也可以)
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (error) {
        NSLog(@"搜索特征%@时发生错误%@",service.UUID,[error localizedDescription]);
        return;
    }
    NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
    
    for (CBCharacteristic *cha in service.characteristics) {
        NSLog(@"%s, line = %d, char = %@", __FUNCTION__, __LINE__, cha);
        _writeCharacteristic = cha;
        //直接对其特征值进行扫描
        [peripheral discoverCharacteristics:nil forService:service];
        
        NSData *value = [self dataWithHexstring:@"链接设备"];
        [self.peripheral writeValue:value forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithResponse];//第一个参数是已连接的蓝牙设备 ；第二个参数是要写入到哪个特征； 第三个参数是通过此响应记录是否成功写入
        
    }
}
//6.从外围设备读数据

// 更新特征的value的时候会调用 （凡是从蓝牙传过来的数据都要经过这个回调，简单的说这个方法就是你拿数据的唯一方法） 你可以判断是否
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
    if (characteristic == @"你要的特征的UUID或者是你已经找到的特征") {
        //characteristic.value就是你要的数据
    }
}

// 需要注意的是特征的属性是否支持写数据
- (void)yf_peripheral:(CBPeripheral *)peripheral didWriteData:(NSData *)data forCharacteristic:(nonnull CBCharacteristic *)characteristic
{
    /*
     typedef NS_OPTIONS(NSUInteger, CBCharacteristicProperties) {
     CBCharacteristicPropertyBroadcast                                                = 0x01,
     CBCharacteristicPropertyRead                                                    = 0x02,
     CBCharacteristicPropertyWriteWithoutResponse                                    = 0x04,
     CBCharacteristicPropertyWrite                                                    = 0x08,
     CBCharacteristicPropertyNotify                                                    = 0x10,
     CBCharacteristicPropertyIndicate                                                = 0x20,
     CBCharacteristicPropertyAuthenticatedSignedWrites                                = 0x40,
     CBCharacteristicPropertyExtendedProperties                                        = 0x80,
     CBCharacteristicPropertyNotifyEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)        = 0x100,
     CBCharacteristicPropertyIndicateEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)    = 0x200
     };
     
     打印出特征的权限(characteristic.properties),可以看到有很多种,这是一个NS_OPTIONS的枚举,可以是多个值
     常见的又read,write,noitfy,indicate.知道这几个基本够用了,前俩是读写权限,后俩都是通知,俩不同的通知方式
     */
    NSLog(@"%s, line = %d, char.pro = %d", __FUNCTION__, __LINE__, characteristic.properties);
    // 此时由于枚举属性是NS_OPTIONS,所以一个枚举可能对应多个类型,所以判断不能用 = ,而应该用包含&
    //7.给外围设备发送数据（也就是写入数据到蓝牙）
    //这个方法你可以放在button的响应里面，也可以在找到特征的时候就写入，具体看你业务需求怎么用啦
    
    [self.peripheral writeValue:data forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithResponse];//第一个参数是已连接的蓝牙设备 ；第二个参数是要写入到哪个特征； 第三个参数是通过此响应记录是否成功写入
}
@end
