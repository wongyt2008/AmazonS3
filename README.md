AmazonS3
========

This is for me to use IAM,Cognito and Amazon S3
//In AppDelegate 

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    AWSCognitoCredentialsProvider *credentialsProvider = [AWSCognitoCredentialsProvider
                                                          credentialsWithRegionType:XXXXXXXXXX
                                                          accountId:@"XXXXXXXX"
                                                          identityPoolId:@"XXXXXXXXXXXX"
                                                          unauthRoleArn:@"XXXXXXXXXXXXX"
                                                          authRoleArn:@"XXXXXXXXXXXX"];
    
    AWSServiceConfiguration *configuration = [AWSServiceConfiguration configurationWithRegion:AWSRegionUSEast1
                                                                          credentialsProvider:credentialsProvider];
    
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
    

    [[credentialsProvider getIdentityId] continueWithSuccessBlock:^id(BFTask *task){
        NSString* cognitoId = credentialsProvider.identityId;
        NSLog(@"cognitoId: %@", cognitoId);  //It can print the cognitoId out. 
        //[self launchCount];
        return nil;
    }];

 
    return YES;
}



//In controllerView.m: 

- (IBAction)uploadButtonPressed:(id)sender{
    
    //defaultS3TransferManager makes the app crash, if i change it to  [AWSS3TransferManager alloc]init], no crash but nothing can 
    //be uploaded to S3
    
    
    AWSS3TransferManager *transferManager =  [AWSS3TransferManager defaultS3TransferManager];
    
    self.uploadStatusLabel.text = @"Uploading" ;
    
    

    self.uploadRequest = [AWSS3TransferManagerUploadRequest new];
    
    self.uploadRequest.bucket = S3BucketName;
    
    self.uploadRequest.key = S3KeyName;
    
    
    self.uploadRequest.body = self.testFileURL;

    
    [[transferManager upload:self.uploadRequest] continueWithExecutor:[BFExecutor mainThreadExecutor] withBlock:^id(BFTask *task) {
        if (task.error != nil) {
            NSLog(@"Error: [%@]", task.error);
            self.uploadStatusLabel.text =@"StatusLabelFailed";
  
    }
     else {
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




