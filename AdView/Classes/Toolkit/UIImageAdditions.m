#import "UIImageAdditions.h"

@implementation UIImage (MCCategory)

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (void)addRoundedRectToPath:(CGContextRef)context rect:(CGRect)rect radius:(float)radius {
  CGContextBeginPath(context);
  CGContextSaveGState(context);
 
  if (radius == 0) {
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddRect(context, rect);
  } else {
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, radius, radius);
    float fw = CGRectGetWidth(rect) / radius;
    float fh = CGRectGetHeight(rect) / radius;
    
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
  }

  CGContextClosePath(context);
  CGContextRestoreGState(context);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// public

- (UIImage *) roundCorners: (UIImage*) img
{
    int w = img.size.width;
    int h = img.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    [self addRoundedRectToPath:context rect:rect radius:5];
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);

    
    return [UIImage imageWithCGImage:imageMasked];
}

- (UIImage*)transformWidth:(CGFloat)width height:(CGFloat)height rotate:(BOOL)rotate {
  CGFloat destW = width;
  CGFloat destH = height;
  CGFloat sourceW = width;
  CGFloat sourceH = height;
  if (rotate) {
    if (self.imageOrientation == UIImageOrientationRight
        || self.imageOrientation == UIImageOrientationLeft) {
      sourceW = height;
      sourceH = width;
    }
  }
  
  CGImageRef imageRef = self.CGImage;
  CGContextRef bitmap = CGBitmapContextCreate(NULL, destW, destH,
    CGImageGetBitsPerComponent(imageRef), 4*destW, CGImageGetColorSpace(imageRef),
    CGImageGetBitmapInfo(imageRef));

  if (rotate) {
    if (self.imageOrientation == UIImageOrientationDown) {
      CGContextTranslateCTM(bitmap, sourceW, sourceH);
      CGContextRotateCTM(bitmap, 180 * (M_PI/180));
    } else if (self.imageOrientation == UIImageOrientationLeft) {
      CGContextTranslateCTM(bitmap, sourceH, 0);
      CGContextRotateCTM(bitmap, 90 * (M_PI/180));
    } else if (self.imageOrientation == UIImageOrientationRight) {
      CGContextTranslateCTM(bitmap, 0, sourceW);
      CGContextRotateCTM(bitmap, -90 * (M_PI/180));
    }
  }

  CGContextDrawImage(bitmap, CGRectMake(0,0,sourceW,sourceH), imageRef);

  CGImageRef ref = CGBitmapContextCreateImage(bitmap);
  UIImage* result = [UIImage imageWithCGImage:ref];
  CGContextRelease(bitmap);
  CGImageRelease(ref);

  return result;
}

- (void)drawInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode {
  BOOL clip = NO;
  CGRect originalRect = rect;
  if (self.size.width != rect.size.width || self.size.height != rect.size.height) {
    if (contentMode == UIViewContentModeLeft) {
      rect = CGRectMake(rect.origin.x,
                        rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeRight) {
      rect = CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
                        rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeTop) {
      rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
                        rect.origin.y,
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeBottom) {
      rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
                        rect.origin.y + floor(rect.size.height - self.size.height),
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeCenter) {
      rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
                        rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
                        self.size.width, self.size.height);
    } else if (contentMode == UIViewContentModeBottomLeft) {
      rect = CGRectMake(rect.origin.x,
                        rect.origin.y + floor(rect.size.height - self.size.height),
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeBottomRight) {
      rect = CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
                        rect.origin.y + (rect.size.height - self.size.height),
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeTopLeft) {
      rect = CGRectMake(rect.origin.x,
                        rect.origin.y,
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeTopRight) {
      rect = CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
                        rect.origin.y,
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeScaleAspectFill) {
      CGSize imageSize = self.size;
      if (imageSize.height < imageSize.width) {
        imageSize.width = floor((imageSize.width/imageSize.height) * rect.size.height);
        imageSize.height = rect.size.height;
      } else {
        imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
        imageSize.width = rect.size.width;
      }
      rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2),
                        rect.origin.y + floor(rect.size.height/2 - imageSize.height/2),
                        imageSize.width, imageSize.height);
    } else if (contentMode == UIViewContentModeScaleAspectFit) {
      CGSize imageSize = self.size;
      if (imageSize.height < imageSize.width) {
        imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
        imageSize.width = rect.size.width;
      } else {
        imageSize.width = floor((imageSize.width/imageSize.height) * rect.size.height);
        imageSize.height = rect.size.height;
      }
      rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2),
                        rect.origin.y + floor(rect.size.height/2 - imageSize.height/2),
                        imageSize.width, imageSize.height);
    }
  }
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  if (clip) {
    CGContextSaveGState(context);
    CGContextAddRect(context, originalRect);
    CGContextClip(context);
  }

  [self drawInRect:rect];

  if (clip) {
    CGContextRestoreGState(context);
  }
}

- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius contentMode:(UIViewContentMode)contentMode {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	if (radius) {
		[self addRoundedRectToPath:context rect:rect radius:radius];
		CGContextClip(context);
	}
	
	[self drawInRect:rect contentMode:contentMode];
	
	CGContextRestoreGState(context);
}

- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius {
  [self drawInRect:rect radius:radius contentMode:UIViewContentModeScaleToFill];
}

-(UIImage*)scaleToSize:(CGSize)size  
{  
    // 创建一个bitmap的context  
    // 并把它设置成为当前正在使用的context  
    UIGraphicsBeginImageContext(size);  
	
    // 绘制改变大小的图片  
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];  
	
    // 从当前context中创建一个改变大小后的图片  
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();  
	
    // 使当前的context出堆栈  
    UIGraphicsEndImageContext();  
	
    // 返回新的改变大小后的图片  
    return scaledImage;  
}  
@end
