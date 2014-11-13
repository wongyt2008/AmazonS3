#import "ViewController.h"
#import <AWSiOSSDKv2/S3.h>
#import <AWSiOSSDKv2/DynamoDB.h>
#import <AWSiOSSDKv2/AWSCore.h>
#import "constant.h"


@interface ViewController ()


@property (nonatomic, strong) NSURL *testFileURL;

@property (nonatomic, strong) AWSS3TransferManagerUploadRequest *uploadRequest;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView1;
@property (nonatomic) uint64_t file1Size;
@property (nonatomic) uint64_t file1AlreadyUpload;


@end


- (IBAction)uploadButtonPressed:(id)sender{
   
    
    AWSS3TransferManager *transferManager = [AWSS3TransferManager new];
    
    
    self.testFileURL = [NSURL fileURLWithPath:[NSTemporaryDirectory()stringByAppendingPathComponent:@"upload1.txt"]];
                        
    self.uploadRequest = [AWSS3TransferManagerUploadRequest new];
                        

    
    NSData *data = UIImageJPEGRepresentation(self.image.image, 0.5);
    
    
    data = [NSData dataWithContentsOfURL:self.testFileURL];
    
    self.uploadRequest.bucket = S3BucketName;
    
    self.uploadRequest.key = @"example1.jpg";
    
    
    self.uploadRequest.body = self.testFileURL;
    
    [[transferManager upload:self.uploadRequest] continueWithExecutor:[BFExecutor mainThreadExecutor] withBlock:^id(BFTask *task) {
        if (task.error != nil) {
            
            {
                self.uploadStatusLabel.text = @"StatusLabelFailed";
                NSLog(@"Error: [%@]", task.error);
            }
        } else {
            self.uploadRequest = nil;
           
                self.uploadStatusLabel.text = @"StatusLabelCompleted";
            }
        
        return nil;
    }];


     
     }
     
     
     
     
     
- (void)viewDidLoad {
    [super viewDidLoad];

    BFTask *task = [BFTask taskWithResult:nil];
    [[task continueWithBlock:^id(BFTask *task) {
        
         //Creates a test file in the temporary directory
        self.testFileURL = [NSURL fileURLWithPath:[NSTemporaryDirectory()
                                                   stringByAppendingPathComponent:S3KeyName]];
        
        
        NSMutableString *dataString = [NSMutableString new];
        for (int32_t i = 1; i < 2000000; i++) {
            [dataString appendFormat:@"%d\n", i];
            
            
        }
        
        NSError *error = nil;
        [dataString writeToURL:self.testFileURL
                    atomically:YES
                      encoding:NSUTF8StringEncoding
                         error:&error];
        return nil;
    }] continueWithExecutor:[BFExecutor mainThreadExecutor] withBlock:^id(BFTask
                                                                          *task) {
        self.uploadButton.enabled = YES;
        self.pauseButton.enabled = YES;
        self.resumeButton.enabled = YES;
        self.cancelButton.enabled = YES;
        return nil;
    }];
    
   
}
