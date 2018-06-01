//
//  ViewController.m
//  XXARDemoBox
//
//  Created by XXViper on 2018/5/31.
//  Copyright © 2018年 XXViper. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <ARSCNViewDelegate>

@property (nonatomic, strong) IBOutlet ARSCNView *sceneView;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UIButton *moveGunBtn;

@property (nonatomic, strong) UIButton *moveComeBtn;

@end

    
@implementation ViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    // Set the view's delegate
//    self.sceneView.delegate = self;
//
//    // Show statistics such as fps and timing information
//    self.sceneView.showsStatistics = YES;
//
//    // Create a new scene
//    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
//
//    // Set the scene to the view
//    self.sceneView.scene = scene;
//}
- (void)viewDidLoad{
    [super viewDidLoad];
    // Set the view's delegate
    self.sceneView.delegate = self;

    // Show statistics such as fps and timing information
    self.sceneView.showsStatistics = YES;
    
    //添加按钮
    self.addBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 40, 60, 40)];
    [self.addBtn setTitle:@"添加" forState:UIControlStateNormal];
    self.addBtn.backgroundColor = [UIColor redColor];
    [self.addBtn addTarget:self action:@selector(addNoteClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addBtn];
    
    //移动按钮
    self.moveGunBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-40, 60, 40)];
    [self.moveGunBtn setTitle:@"离远点" forState:UIControlStateNormal];
    self.moveGunBtn.backgroundColor = [UIColor greenColor];
        [self.moveGunBtn addTarget:self action:@selector(moveGunNoteClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.moveGunBtn];
    
    //移动按钮
    self.moveComeBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-40, [UIScreen mainScreen].bounds.size.height-40, 60, 40)];
    [self.moveComeBtn setTitle:@"靠近点" forState:UIControlStateNormal];
    self.moveComeBtn.backgroundColor = [UIColor orangeColor];
    [self.moveComeBtn addTarget:self action:@selector(moveComeNoteClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.moveComeBtn];
}

- (void)addNoteClick:(UIButton *)btn{
    
    //想要绘制的3D立方体
    SCNBox *boxGeometry = [SCNBox boxWithWidth:0.1 height:0.1 length:0.1 chamferRadius:0.0];
    
    //将集合体包装成node以便添加
    SCNNode *boxNode = [SCNNode nodeWithGeometry:boxGeometry];
    
    //把box放在摄像头正前方
    boxNode.position = SCNVector3Make(0, -0.25, -0.5);
    
    //创建渲染器
    SCNMaterial *material = [SCNMaterial material];
    material.diffuse.contents = [UIColor colorWithRed:arc4random()%256 / 255.0 green:arc4random()%256 / 255.0 blue:arc4random()%256 / 255.0 alpha:1];
    
    //用渲染器对任何徒刑进行渲染
    boxGeometry.materials = @[material];
    
    //存放所有3D集合体的容器
    //rootNode是一个特殊的node,是所有node的起始点
    [_sceneView.scene.rootNode addChildNode:boxNode];
}
- (void)moveGunNoteClick:(UIButton *)btn{
    NSLog(@"gun!");
    NSArray *childNodes = _sceneView.scene.rootNode.childNodes;
    for (SCNNode *node in childNodes) {
        node.position = SCNVector3Make(node.position.x,node.position.y,node.position.z-0.1);
    }
}

- (void)moveComeNoteClick:(UIButton *)btn{
    NSLog(@"come!");
    NSArray *childNodes = _sceneView.scene.rootNode.childNodes;
    for (SCNNode *node in childNodes) {
        node.position = SCNVector3Make(node.position.x,node.position.y,node.position.z+0.1);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create a session configuration
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];

    // Run the view's session
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
