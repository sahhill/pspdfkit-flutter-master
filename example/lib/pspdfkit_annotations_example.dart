///
///  Copyright © 2018-2022 PSPDFKit GmbH. All rights reserved.
///
///  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
///  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
///  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
///  This notice may not be removed from this file.
///

import 'dart:async';

import 'package:easy_container/easy_container.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:pspdfkit_example/utils/file_utils.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart';

import 'package:pspdfkit_flutter/widgets/pspdfkit_widget_controller.dart';

import 'utils/platform_utils.dart';

Map<String, dynamic> annotationJsonHashMap = <String, dynamic>{
  'uuid': 'A92AA288-B11D-490C-847B-D1A0BC64D3E9',
  'bbox': [
    267.4294738769531,
    335.1297607421875,
    97.16720581054688,
    10.305419921875
  ],
  'blendMode': 'normal',
  'updatedAt': '2020-04-01T12:31:15Z',
  'pageIndex': 0,
  'lineWidth': 4,
  'lines': {
    'points': [
      [
        [269.4294738769531, 343.4351806640625],
        [308.458984375, 341.7537841796875],
        [341.19342041015625, 339.6519775390625],
        [358.81964111328125, 339.6519775390625],
        [360.9179992675781, 339.2315673828125],
        [362.5966796875, 338.81121826171875],
        [361.7573547363281, 337.1297607421875]
      ]
    ],
    'intensities': [
      [
        1,
        0.42835134267807007,
        0.635690450668335,
        0.827924370765686,
        0.9846339821815491,
        0.9947978258132935,
        0.9675101041793823
      ]
    ]
  },
  'strokeColor': '#2492FB',
  'isDrawnNaturally': false,
  'opacity': 1,
  'type': 'pspdfkit/ink',
  'creatorName': 'pspdfkit',
  'createdAt': '2020-04-01T12:31:15Z',
  'name': 'A92AA288-B11D-490C-847B-D1A0BC64D3E9',
  'v': 1
};

class PspdfkitAnnotationsExampleWidget extends StatefulWidget {
  final String documentPath;
  final dynamic configuration;

  const PspdfkitAnnotationsExampleWidget(
      {Key? key, required this.documentPath, this.configuration})
      : super(key: key);

  @override
  _PspdfkitAnnotationsExampleWidgetState createState() =>
      _PspdfkitAnnotationsExampleWidgetState();
}

class _PspdfkitAnnotationsExampleWidgetState
    extends State<PspdfkitAnnotationsExampleWidget> {
  late PspdfkitWidgetController view;
  String annotationJsonString() => '''
{
	"v": 1,
	"pageIndex": $pageIndex,
	"bbox": [300, 500, 240, 140],
	"opacity": 1,
	"pdfObjectId": 200,
	"creatorName": "John Doe",
	"createdAt": "2012-04-23T18:25:43.511Z",
	"updatedAt": "2012-04-23T18:28:05.100Z",
	"id": "01F46S31WM8Q46MP3T0BAJ0F85",
	"name": "01F46S31WM8Q46MP3T0BAJ0F85",
	"type": "pspdfkit/text",
	"text": "Content for a text annotation text 1",
	"fontSize": 32,
	"fontStyle": ["bold"],
	"fontColor": "#000000",
	"horizontalAlign": "left",
	"verticalAlign": "center",
	"rotation": 0
}''';

  String annotationJsonString2() => '''
{
	"v": 1,
	"pageIndex": $pageIndex,
	"bbox": [300, 500, 240, 140],
	"opacity": 1,
	"pdfObjectId": 200,
	"creatorName": "John Doe",
	"createdAt": "2012-04-23T18:25:43.511Z",
	"updatedAt": "2012-04-23T18:28:05.100Z",
	"id": "01F46S31WM8Q46MP3T0BAJ0F85",
	"name": "01F46S31WM8Q46MP3T0BAJ0F85",
	"type": "pspdfkit/text",
	"text": "Content for a text annotation text 2",
	"fontSize": 32,
	"fontStyle": ["bold"],
	"fontColor": "#000000",
	"horizontalAlign": "left",
	"verticalAlign": "center",
	"rotation": 0
}''';

  void spreadIndexDidChangeHandler(dynamic arguments) {
    print('yooo' + arguments.toString());
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('yooo' + {await Pspdfkit().getPageIndex}.toString());
  }

  int pageIndex = 1;
  @override
  Widget build(BuildContext context) {
    // Pspdfkit.pageIndexDidChange =
    // (dynamic arguments) => spreadIndexDidChangeHandler(arguments);
    // view.addAnnotation(jsonAnnotation);
    // This is used in the platform side to register the view.
    const String viewType = 'com.pspdfkit.widget';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{
      'document': widget.documentPath,
      'configuration': widget.configuration
    };
    if (PlatformUtils.isCurrentPlatformSupported()) {
      return WillPopScope(
        onWillPop: (() {
          return Future.value(false);
        }),
        child: Scaffold(
            extendBodyBehindAppBar: PlatformUtils.isAndroid(),
            // appBar: AppBar(),
            body: SafeArea(
                top: false,
                bottom: false,
                child: EasyContainer(
                    child: Row(children: <Widget>[
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Center(child: Text("Questions")),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            "Section A",
                            style: TextStyle(
                                color: Colors.blue[800], fontSize: 24),
                          ),
                          Card(
                            child: Column(
                              children: [
                                EasyContainer(
                                  alignment: Alignment.topLeft,
                                  color: Colors.blue[600],
                                  child: Text(
                                    'Q1',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Text("Answer in 100 words"),
                                const Divider(),
                                Text(" a) This is a question 1"),
                                Row(
                                  children: [
                                    EasyContainer(
                                      child: Text("Show annotations"),
                                    ),
                                    // EasyContainer(),
                                    Text("/"),
                                    EasyContainer(
                                      child: Text("10"),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 8,
                      child: PlatformUtils.isAndroid()
                          ? PlatformViewLink(
                              viewType: viewType,
                              surfaceFactory: (BuildContext context,
                                  PlatformViewController controller) {
                                return AndroidViewSurface(
                                  controller: controller
                                      as AndroidViewController,
                                  gestureRecognizers: const <
                                      Factory<
                                          OneSequenceGestureRecognizer>>{},
                                  hitTestBehavior:
                                      PlatformViewHitTestBehavior
                                          .opaque,
                                );
                              },
                              onCreatePlatformView:
                                  (PlatformViewCreationParams params) {
                                debugPrint(
                                    "viewId ${params.toString()}");
                                return PlatformViewsService
                                    .initSurfaceAndroidView(
                                  id: params.id,
                                  viewType: viewType,
                                  layoutDirection: TextDirection.ltr,
                                  creationParams: creationParams,
                                  creationParamsCodec:
                                      const StandardMessageCodec(),
                                  onFocus: () {
                                    params.onFocusChanged(true);
                                  },
                                )
                                  ..addOnPlatformViewCreatedListener(
                                      params.onPlatformViewCreated)
                                  ..addOnPlatformViewCreatedListener(
                                      onPlatformViewCreated)
                                  ..create();
                              })
                          : UiKitView(
                              viewType: viewType,
                              layoutDirection: TextDirection.ltr,
                              creationParams: creationParams,
                              onPlatformViewCreated: onPlatformViewCreated,
                              creationParamsCodec:
                                  const StandardMessageCodec())),
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          child: Column(children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Text("Annotations"),
                        SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              debugPrint("pageIndex $pageIndex");
                              await Clipboard.setData(ClipboardData(
                                  text: "This is a text annotation 1"));
                              // await view.addAnnotation(annotationJsonHashMap);
                              // // To test the `view#addAnnotation` method with an InstantJSON string
                              // // simply use `annotationJsonString` instead or `annotationJsonHashMap`.
                              // await view
                              //     .addAnnotation(annotationJsonString());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text(
                                  'Add Content for a text annotation text 1, copy and add'),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              // await view.addAnnotation(annotationJsonHashMap);
                              // // To test the `view#addAnnotation` method with an InstantJSON string
                              // // simply use `annotationJsonString` instead or `annotationJsonHashMap`.
                              await view
                                  .addAnnotation(annotationJsonString2());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text(
                                  'Add Content for a text annotation text 2'),
                            )),
                        // if (PlatformUtils.isIOS())
                        //   ElevatedButton(
                        //       onPressed: () async {
                        //         dynamic annotationsJson =
                        //             await view.getAnnotations(0, 'all');
                        //         await view.removeAnnotation({
                        //           'uuid': annotationsJson[0]['uuid'] as String
                        //         });
                        //       },
                        //       child: const Text('Remove Annotation')),
                        // ElevatedButton(
                        //     onPressed: () async {
                        //       const title = 'Annotation JSON';
                        //       dynamic annotationsJson =
                        //           await view.getAnnotations(0, 'all');
                        //       await showDialog<AlertDialog>(
                        //           context: context,
                        //           builder: (BuildContext context) =>
                        //               AlertDialog(
                        //                   title: const Text(title),
                        //                   content: Text('$annotationsJson'),
                        //                   actions: [
                        //                     TextButton(
                        //                         onPressed: () {
                        //                           Navigator.of(context).pop();
                        //                         },
                        //                         child: const Text('OK'))
                        //                   ]));
                        //     },
                        //     child: const Text('Get Annotations')),
                        // ElevatedButton(
                        // onPressed: () async {
                        //   const title = 'Unsaved Annotations';
                        //   dynamic annotationsJson =
                        //       await view.getAllUnsavedAnnotations();
                        //   print(annotationsJson);
                        //   await showDialog<AlertDialog>(
                        //       context: context,
                        //       builder: (BuildContext context) =>
                        //           AlertDialog(
                        //             title: const Text(title),
                        //             content: Text('$annotationsJson'),
                        //             actions: [
                        //               TextButton(
                        //                   onPressed: () {
                        //                     Navigator.of(context).pop();
                        //                   },
                        //                   child: const Text('OK'))
                        //             ],
                        //           ));
                        // },
                        // child: const Text('Get All Unsaved Annotations'))
                      ])),
                    ),
                  )
                ])))),
      );
    } else {
      return Text(
          '$defaultTargetPlatform is not yet supported by PSPDFKit for Flutter.');
    }
  }

  Future<void> onPlatformViewCreated(int id) async {
    view = PspdfkitWidgetController(id);
  }
}
