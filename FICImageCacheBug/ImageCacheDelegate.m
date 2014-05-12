#import "ImageCacheDelegate.h"
#import <AFNetworking/AFHTTPRequestOperation.h>
#import <AFNetworking/AFURLResponseSerialization.h>

NSString *const ImageCacheProgressNotification = @"ImageCacheProgressNotification";

@implementation ImageCacheDelegate {
    NSOperationQueue *_operationQueue;
    AFImageResponseSerializer *_imageResponseSerializer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _imageResponseSerializer = [AFImageResponseSerializer new];
        _operationQueue = [NSOperationQueue new];
    }
    return self;
}

-(void)imageCache:(FICImageCache *)imageCache wantsSourceImageForEntity:(id<FICEntity>)entity withFormatName:(NSString *)formatName completionBlock:(FICImageRequestCompletionBlock)completionBlock
{
    NSURL *url = [entity sourceImageURLWithFormatName:formatName];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFHTTPRequestOperation *operation;
    
    operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = _imageResponseSerializer;
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseImage) {
        completionBlock(responseImage);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image download failure %@", [error localizedDescription]);
        completionBlock(nil);
    }];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];

    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        NSNumber *progress = @(totalBytesRead / (float)totalBytesExpectedToRead);
        [center postNotificationName:ImageCacheProgressNotification
                              object:entity
                            userInfo:NSDictionaryOfVariableBindings(formatName, progress)];
    }];
    
    [operation setShouldExecuteAsBackgroundTaskWithExpirationHandler:nil];
    
    [_operationQueue addOperation:operation];
}
-(BOOL)imageCache:(FICImageCache *)imageCache shouldProcessAllFormatsInFamily:(NSString *)formatFamily forEntity:(id<FICEntity>)entity
{
    return NO;
}

-(void)imageCache:(FICImageCache *)imageCache errorDidOccurWithMessage:(NSString *)errorMessage
{
    NSLog(@"%@", errorMessage);
}
-(void)imageCache:(FICImageCache *)imageCache cancelImageLoadingForEntity:(id<FICEntity>)entity withFormatName:(NSString *)formatName
{
        //TODO: maintain map of entity/formatName to operation and cancel
}
@end
