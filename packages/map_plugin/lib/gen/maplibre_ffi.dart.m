#include <stdint.h>
#import <Foundation/Foundation.h>
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNMapView.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNPolyline.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNFillExtrusionStyleLayer.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNVectorTileSource.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNMapCamera.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNUserLocationAnnotationViewStyle.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNCustomStyleLayer.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNFoundation.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNCalloutView.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNCameraChangeReason.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNLoggingConfiguration.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/Mapbox.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNVectorStyleLayer.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNTileOperation.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNCoordinateFormatter.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNTilePyramidOfflineRegion.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/NSValue+MLNAdditions.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNImageSource.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNTileServerOptions.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNShapeOfflineRegion.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNOverlay.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNClockDirectionFormatter.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNMapView+IBAdditions.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNFeature.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNNetworkConfiguration.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNMapProjection.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNSettings.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNStyleValue.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/NSPredicate+MLNAdditions.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNSource.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNAttributedExpression.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNCompassDirectionFormatter.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNLineStyleLayer.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNShapeCollection.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNForegroundStyleLayer.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNPolygon.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNHeatmapStyleLayer.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNRasterStyleLayer.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNRasterDEMSource.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNStyleLayer.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNOfflineRegion.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNCustomDrawableStyleLayer.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNCluster.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNUserLocationAnnotationView.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNTileSource.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNRasterTileSource.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNBackgroundStyleLayer.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNBackendResource.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNDefaultStyle.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNAnnotation.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNGeometry.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNOfflinePack.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNStyle.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNSymbolStyleLayer.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNLight.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNTypes.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MapLibre.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNAnnotationImage.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNComputedShapeSource.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNPointAnnotation.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNPointCollection.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNMapView.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/NSExpression+MLNAdditions.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNMultiPoint.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNShapeSource.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNCompassButton.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNLocationManager.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNDistanceFormatter.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNMapSnapshotter.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNUserLocation.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNMapViewDelegate.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNShape.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNFillStyleLayer.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNCircleStyleLayer.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNScaleBar.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNAttributionInfo.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNOfflineStorage.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNAnnotationView.h"
#import "../../temp/MapLibre.xcframework/ios-arm64/MapLibre.framework/Headers/MLNHillshadeStyleLayer.h"

#if !__has_feature(objc_arc)
#error "This file must be compiled with ARC enabled"
#endif

id objc_retainBlock(id);

typedef void  (^_ListenerTrampoline)(id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _MapLibreFFi_wrapListenerBlock_pfv6jd(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline)(void * waiter, id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _MapLibreFFi_wrapBlockingBlock_pfv6jd(
    _BlockingTrampoline block, _BlockingTrampoline listenerBlock,
    void* (*newWaiter)(), void (*awaitWaiter)(void*)) NS_RETURNS_RETAINED {
  NSThread *targetThread = [NSThread currentThread];
  return ^void(id arg0, id arg1) {
    if ([NSThread currentThread] == targetThread) {
      objc_retainBlock(block);
      block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
    } else {
      void* waiter = newWaiter();
      objc_retainBlock(listenerBlock);
      listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
      awaitWaiter(waiter);
    }
  };
}

typedef void  (^_ListenerTrampoline1)();
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline1 _MapLibreFFi_wrapListenerBlock_1pl9qdv(_ListenerTrampoline1 block) NS_RETURNS_RETAINED {
  return ^void() {
    objc_retainBlock(block);
    block();
  };
}

typedef void  (^_BlockingTrampoline1)(void * waiter);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline1 _MapLibreFFi_wrapBlockingBlock_1pl9qdv(
    _BlockingTrampoline1 block, _BlockingTrampoline1 listenerBlock,
    void* (*newWaiter)(), void (*awaitWaiter)(void*)) NS_RETURNS_RETAINED {
  NSThread *targetThread = [NSThread currentThread];
  return ^void() {
    if ([NSThread currentThread] == targetThread) {
      objc_retainBlock(block);
      block(nil);
    } else {
      void* waiter = newWaiter();
      objc_retainBlock(listenerBlock);
      listenerBlock(waiter);
      awaitWaiter(waiter);
    }
  };
}

typedef void  (^_ListenerTrampoline2)(id arg0, struct _NSRange arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline2 _MapLibreFFi_wrapListenerBlock_1a22wz(_ListenerTrampoline2 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline2)(void * waiter, id arg0, struct _NSRange arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline2 _MapLibreFFi_wrapBlockingBlock_1a22wz(
    _BlockingTrampoline2 block, _BlockingTrampoline2 listenerBlock,
    void* (*newWaiter)(), void (*awaitWaiter)(void*)) NS_RETURNS_RETAINED {
  NSThread *targetThread = [NSThread currentThread];
  return ^void(id arg0, struct _NSRange arg1, BOOL * arg2) {
    if ([NSThread currentThread] == targetThread) {
      objc_retainBlock(block);
      block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
    } else {
      void* waiter = newWaiter();
      objc_retainBlock(listenerBlock);
      listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
      awaitWaiter(waiter);
    }
  };
}

Protocol* _MapLibreFFi_NSPasteboardReading(void) { return @protocol(NSPasteboardReading); }

Protocol* _MapLibreFFi_NSPasteboardWriting(void) { return @protocol(NSPasteboardWriting); }

typedef void  (^_ListenerTrampoline3)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline3 _MapLibreFFi_wrapListenerBlock_18v1jvf(_ListenerTrampoline3 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline3)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline3 _MapLibreFFi_wrapBlockingBlock_18v1jvf(
    _BlockingTrampoline3 block, _BlockingTrampoline3 listenerBlock,
    void* (*newWaiter)(), void (*awaitWaiter)(void*)) NS_RETURNS_RETAINED {
  NSThread *targetThread = [NSThread currentThread];
  return ^void(void * arg0, id arg1) {
    if ([NSThread currentThread] == targetThread) {
      objc_retainBlock(block);
      block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
    } else {
      void* waiter = newWaiter();
      objc_retainBlock(listenerBlock);
      listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
      awaitWaiter(waiter);
    }
  };
}

typedef void  (^_ListenerTrampoline4)(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline4 _MapLibreFFi_wrapListenerBlock_lmc3p5(_ListenerTrampoline4 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline4)(void * waiter, id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline4 _MapLibreFFi_wrapBlockingBlock_lmc3p5(
    _BlockingTrampoline4 block, _BlockingTrampoline4 listenerBlock,
    void* (*newWaiter)(), void (*awaitWaiter)(void*)) NS_RETURNS_RETAINED {
  NSThread *targetThread = [NSThread currentThread];
  return ^void(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3) {
    if ([NSThread currentThread] == targetThread) {
      objc_retainBlock(block);
      block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
    } else {
      void* waiter = newWaiter();
      objc_retainBlock(listenerBlock);
      listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
      awaitWaiter(waiter);
    }
  };
}

Protocol* _MapLibreFFi_NSImageDelegate(void) { return @protocol(NSImageDelegate); }

Protocol* _MapLibreFFi_MLNStylable(void) { return @protocol(MLNStylable); }

Protocol* _MapLibreFFi_MLNMapViewDelegate(void) { return @protocol(MLNMapViewDelegate); }

Protocol* _MapLibreFFi_MLNLocationManager(void) { return @protocol(MLNLocationManager); }

Protocol* _MapLibreFFi_MLNAnnotation(void) { return @protocol(MLNAnnotation); }

Protocol* _MapLibreFFi_MLNOverlay(void) { return @protocol(MLNOverlay); }

Protocol* _MapLibreFFi_MLNCluster(void) { return @protocol(MLNCluster); }

Protocol* _MapLibreFFi_MLNFeature(void) { return @protocol(MLNFeature); }

Protocol* _MapLibreFFi_CTAdaptiveImageProviding(void) { return @protocol(CTAdaptiveImageProviding); }

Protocol* _MapLibreFFi_MLNOfflineRegion(void) { return @protocol(MLNOfflineRegion); }

typedef void  (^_ListenerTrampoline5)(id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline5 _MapLibreFFi_wrapListenerBlock_xtuoz7(_ListenerTrampoline5 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0));
  };
}

typedef void  (^_BlockingTrampoline5)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline5 _MapLibreFFi_wrapBlockingBlock_xtuoz7(
    _BlockingTrampoline5 block, _BlockingTrampoline5 listenerBlock,
    void* (*newWaiter)(), void (*awaitWaiter)(void*)) NS_RETURNS_RETAINED {
  NSThread *targetThread = [NSThread currentThread];
  return ^void(id arg0) {
    if ([NSThread currentThread] == targetThread) {
      objc_retainBlock(block);
      block(nil, (__bridge id)(__bridge_retained void*)(arg0));
    } else {
      void* waiter = newWaiter();
      objc_retainBlock(listenerBlock);
      listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0));
      awaitWaiter(waiter);
    }
  };
}

typedef void  (^_ListenerTrampoline6)(id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline6 _MapLibreFFi_wrapListenerBlock_r8gdi7(_ListenerTrampoline6 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline6)(void * waiter, id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline6 _MapLibreFFi_wrapBlockingBlock_r8gdi7(
    _BlockingTrampoline6 block, _BlockingTrampoline6 listenerBlock,
    void* (*newWaiter)(), void (*awaitWaiter)(void*)) NS_RETURNS_RETAINED {
  NSThread *targetThread = [NSThread currentThread];
  return ^void(id arg0, id arg1, id arg2) {
    if ([NSThread currentThread] == targetThread) {
      objc_retainBlock(block);
      block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
    } else {
      void* waiter = newWaiter();
      objc_retainBlock(listenerBlock);
      listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
      awaitWaiter(waiter);
    }
  };
}

Protocol* _MapLibreFFi_MLNOfflineStorageDelegate(void) { return @protocol(MLNOfflineStorageDelegate); }

typedef void  (^_ListenerTrampoline7)(void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline7 _MapLibreFFi_wrapListenerBlock_10lndml(_ListenerTrampoline7 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline7)(void * waiter, void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline7 _MapLibreFFi_wrapBlockingBlock_10lndml(
    _BlockingTrampoline7 block, _BlockingTrampoline7 listenerBlock,
    void* (*newWaiter)(), void (*awaitWaiter)(void*)) NS_RETURNS_RETAINED {
  NSThread *targetThread = [NSThread currentThread];
  return ^void(void * arg0, BOOL arg1) {
    if ([NSThread currentThread] == targetThread) {
      objc_retainBlock(block);
      block(nil, arg0, arg1);
    } else {
      void* waiter = newWaiter();
      objc_retainBlock(listenerBlock);
      listenerBlock(waiter, arg0, arg1);
      awaitWaiter(waiter);
    }
  };
}

Protocol* _MapLibreFFi_NSTextAttachmentLayout(void) { return @protocol(NSTextAttachmentLayout); }

Protocol* _MapLibreFFi_CKRecordValue(void) { return @protocol(CKRecordValue); }
