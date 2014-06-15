#import <Foundation/Foundation.h>

#define API_VERSION @"1.0"
#define API_HTTP @"http://labs.bkklive.com/demo/movie/api/"
#define API_HTTPS @"https://labs.bkklive.com/demo/movie/api/"
#define API_PREFIX @""





#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))
#define IS_IPAD_RETINA (IS_IPAD && IS_RETINA)
#define IS_IPHONE_SHORT ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && [[UIScreen mainScreen] bounds].size.height < 568.0f)

extern NSString *M_TABLE;
extern NSString *M_SAVE_PHOTO_EMAIL;


typedef void (^APICallback)();
typedef void (^APISuccess)(id);
typedef void (^APIFail)(NSError*);

@class AMMViewController;

@interface API : NSObject

+ (API *)getAPI;

@property (nonatomic, strong) NSMutableDictionary *mClientInfoDict;
@property (nonatomic, strong) NSMutableDictionary *mDataDict;
@property (nonatomic, assign) AMMViewController *mVC;
@property (nonatomic, strong) NSString *mDeviceToken;
@property (nonatomic, strong) UIImage *mImageCurrent;
@property (nonatomic, strong) UIView *mViewFrame;
@property (nonatomic, strong) NSString *mImageID;

// Localize
- (NSString*)getLanguage;
- (void)setLanguage:(NSString *)l;
- (NSString *)translate:(NSString *)key;


// Persistence
- (id)getObject:(NSString*)key;
- (void)saveObject:(id)obj forKey:(NSString*)key;
- (void)deleteObject:(NSString*)key;
- (void)clearAllUserDefault;

// API
- (void)api_cancel_all_call;

- (void)api_upload:(UIImage*)image
             email:(NSString*)email
           success:(APISuccess)success
           failure:(APIFail)failure;

- (void)gotoEndOfLine;

- (void)savePhoto:(NSDictionary *)info;
@end




