//
//  ViewController.m
//  XXARDemoHellowWrold
//
//  Created by XXViper on 2018/5/27.
//  Copyright © 2018年 XXViper. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <ARSCNViewDelegate>

@property (nonatomic, strong) IBOutlet ARSCNView *sceneView;

@end

    
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set the view's delegate
    //设置代理
    self.sceneView.delegate = self;
    
    // Show statistics such as fps and timing information
    //ARKit统计信息
    self.sceneView.showsStatistics = YES;
    
    // Create a new scene
    //使用模型创建节点（scn格式文件是一个基于3D建模的文件，使用3DMax软件可以创建，这里系统有一个默认的3D飞机）
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
    
    // Set the scene to the view
    //设置ARKit的场景为SceneKit的当前场景（SCNScene是Scenekit中的场景，类似于UIView）
    self.sceneView.scene = scene;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create a session configuration
    //创建一个追踪设备配置（ARWorldTrackingSessionConfiguration主要负责传感器追踪手机的移动和旋转）
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];

    // Run the view's session
    // 开始启动ARSession会话（启动AR）
    [self.sceneView.session runWithConfiguration:configuration];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    [self.sceneView.session pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - ARSCNViewDelegate

/*
// Override to create and configure nodes for anchors added to the view's session.
- (SCNNode *)renderer:(id<SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
    SCNNode *node = [SCNNode new];
 
    // Add geometry to the node...
 
    return node;
}
*/

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}

@end
