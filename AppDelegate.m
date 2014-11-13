#import "AppDelegate.h"
#import <AWSiOSSDKv2/S3.h>
#import "constant.h"
@interface AppDelegate ()

@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    AWSCognitoCredentialsProvider *credentialsProvider = [AWSCognitoCredentialsProvider
                                                          credentialsWithRegionType:AWSRegionUSEast1
                                                          accountId:@"XXXXXXX"
                                                          identityPoolId:@"us-east-1:XXXXXXXXXXX"
                                                          unauthRoleArn:@"arn:aws:iam::XXXXXXXX:role/Cognito_CognitoTestingUnauth_DefaultRole"
                                                          authRoleArn:@"arn:aws:iam::XXXXXXXXXXX:role/Cognito_CognitoTestingAuth_DefaultRole"];
    
    AWSServiceConfiguration *configuration = [AWSServiceConfiguration configurationWithRegion:AWSRegionUSEast1
                                                                          credentialsProvider:credentialsProvider];
    
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
    
    

    
    
    [[credentialsProvider getIdentityId] continueWithSuccessBlock:^id(BFTask *task){
        NSString* cognitoId = credentialsProvider.identityId;
        NSLog(@"cognitoId: %@", cognitoId);
        //[self launchCount];
        return nil;
    }];

 

    

    
    
    
    
    
    return YES;
}
