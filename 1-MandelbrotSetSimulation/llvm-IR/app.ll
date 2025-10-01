; ModuleID = 'src/app.c'
source_filename = "src/app.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@colorBuf = internal unnamed_addr global [600 x [800 x i32]] zeroinitializer, align 4

; Function Attrs: nounwind ssp uwtable(sync)
define void @app() local_unnamed_addr #0 {
  br label %2

1:                                                ; preds = %83
  ret void

2:                                                ; preds = %0, %83
  %3 = phi i32 [ 0, %0 ], [ %84, %83 ]
  %4 = lshr i32 %3, 1
  %5 = udiv i32 %3, 5
  %6 = mul nsw i32 %3, -780
  %7 = add nsw i32 %6, 400000
  br label %8

8:                                                ; preds = %15, %2
  %9 = phi i64 [ 0, %2 ], [ %16, %15 ]
  %10 = trunc i64 %9 to i32
  %11 = add i32 %10, -300
  %12 = mul nsw i32 %11, %7
  %13 = sdiv i32 %12, 60000
  %14 = add nsw i32 %13, %5
  br label %18

15:                                               ; preds = %65
  %16 = add nuw nsw i64 %9, 1
  %17 = icmp eq i64 %16, 600
  br i1 %17, label %70, label %8, !llvm.loop !6

18:                                               ; preds = %65, %8
  %19 = phi i64 [ 0, %8 ], [ %68, %65 ]
  %20 = trunc i64 %19 to i32
  %21 = add i32 %20, -400
  %22 = mul nsw i32 %21, %7
  %23 = sdiv i32 %22, 80000
  %24 = add nsw i32 %23, -500
  br label %25

25:                                               ; preds = %46, %18
  %26 = phi i32 [ 0, %18 ], [ %47, %46 ]
  %27 = phi i32 [ 0, %18 ], [ %48, %46 ]
  %28 = phi i32 [ 0, %18 ], [ %49, %46 ]
  %29 = icmp slt i32 %26, 50
  br i1 %29, label %30, label %50

30:                                               ; preds = %25
  %31 = mul nsw i32 %28, %28
  %32 = udiv i32 %31, 1000
  %33 = mul nsw i32 %27, %27
  %34 = udiv i32 %33, 1000
  %35 = add nuw nsw i32 %32, %34
  %36 = icmp samesign ult i32 %35, 4001
  br i1 %36, label %37, label %46

37:                                               ; preds = %30
  %38 = add nuw nsw i32 %4, %34
  %39 = sub i32 %24, %38
  %40 = add nsw i32 %39, %32
  %41 = shl nsw i32 %27, 1
  %42 = mul i32 %41, %28
  %43 = sdiv i32 %42, 1000
  %44 = add nsw i32 %14, %43
  %45 = add nsw i32 %26, 1
  br label %46

46:                                               ; preds = %37, %30
  %47 = phi i32 [ %45, %37 ], [ %26, %30 ]
  %48 = phi i32 [ %44, %37 ], [ %27, %30 ]
  %49 = phi i32 [ %40, %37 ], [ %28, %30 ]
  br i1 %36, label %25, label %50

50:                                               ; preds = %46, %25
  %51 = phi i32 [ %47, %46 ], [ %26, %25 ]
  %52 = icmp eq i32 %51, 50
  br i1 %52, label %65, label %53

53:                                               ; preds = %50
  %54 = mul nsw i32 %51, 12
  %55 = srem i32 %54, 256
  %56 = mul nsw i32 %51, 7
  %57 = srem i32 %56, 256
  %58 = mul nsw i32 %51, 3
  %59 = srem i32 %58, 256
  %60 = shl nsw i32 %55, 16
  %61 = shl nsw i32 %57, 8
  %62 = or i32 %59, %61
  %63 = or i32 %62, %60
  %64 = or i32 %63, -16777216
  br label %65

65:                                               ; preds = %53, %50
  %66 = phi i32 [ %64, %53 ], [ -16777216, %50 ]
  %67 = getelementptr inbounds nuw [600 x [800 x i32]], ptr @colorBuf, i64 0, i64 %9, i64 %19
  store i32 %66, ptr %67, align 4, !tbaa !9
  %68 = add nuw nsw i64 %19, 1
  %69 = icmp eq i64 %68, 800
  br i1 %69, label %15, label %18, !llvm.loop !13

70:                                               ; preds = %15, %73
  %71 = phi i64 [ %74, %73 ], [ 0, %15 ]
  %72 = trunc nuw nsw i64 %71 to i32
  br label %76

73:                                               ; preds = %76
  %74 = add nuw nsw i64 %71, 1
  %75 = icmp eq i64 %74, 600
  br i1 %75, label %83, label %70, !llvm.loop !14

76:                                               ; preds = %76, %70
  %77 = phi i64 [ 0, %70 ], [ %81, %76 ]
  %78 = getelementptr inbounds nuw [600 x [800 x i32]], ptr @colorBuf, i64 0, i64 %71, i64 %77
  %79 = load i32, ptr %78, align 4, !tbaa !9
  %80 = trunc nuw nsw i64 %77 to i32
  tail call void @simPutPixel(i32 noundef %80, i32 noundef %72, i32 noundef %79) #2
  %81 = add nuw nsw i64 %77, 1
  %82 = icmp eq i64 %81, 800
  br i1 %82, label %73, label %76, !llvm.loop !15

83:                                               ; preds = %73
  tail call void @simFlush() #2
  %84 = add nuw nsw i32 %3, 1
  %85 = icmp eq i32 %84, 501
  br i1 %85, label %1, label %2, !llvm.loop !16
}

declare void @simPutPixel(i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

declare void @simFlush(...) local_unnamed_addr #1

attributes #0 = { nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 20.1.5"}
!6 = distinct !{!6, !7, !8}
!7 = !{!"llvm.loop.mustprogress"}
!8 = !{!"llvm.loop.unroll.disable"}
!9 = !{!10, !10, i64 0}
!10 = !{!"int", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
!13 = distinct !{!13, !7, !8}
!14 = distinct !{!14, !7, !8}
!15 = distinct !{!15, !7, !8}
!16 = distinct !{!16, !7, !8}
