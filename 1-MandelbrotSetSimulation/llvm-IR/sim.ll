; ModuleID = 'src/sim.c'
source_filename = "src/sim.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

%union.SDL_Event = type { %struct.SDL_SensorEvent, [8 x i8] }
%struct.SDL_SensorEvent = type { i32, i32, i32, [6 x float], i64 }

@Window = internal global ptr null, align 8
@Renderer = internal global ptr null, align 8
@__func__.simFlush = private unnamed_addr constant [9 x i8] c"simFlush\00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"sim.c\00", align 1
@.str.2 = private unnamed_addr constant [60 x i8] c"SDL_TRUE != SDL_HasEvent(SDL_QUIT) && \22User-requested quit\22\00", align 1
@Ticks = internal unnamed_addr global i32 0, align 4
@__func__.simPutPixel = private unnamed_addr constant [12 x i8] c"simPutPixel\00", align 1
@.str.4 = private unnamed_addr constant [43 x i8] c"0 <= x && x < SIM_X_SIZE && \22Out of range\22\00", align 1
@.str.5 = private unnamed_addr constant [43 x i8] c"0 <= y && y < SIM_Y_SIZE && \22Out of range\22\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define void @simInit() local_unnamed_addr #0 {
  %1 = tail call i32 @SDL_Init(i32 noundef 32) #4
  %2 = tail call i32 @SDL_CreateWindowAndRenderer(i32 noundef 800, i32 noundef 600, i32 noundef 0, ptr noundef nonnull @Window, ptr noundef nonnull @Renderer) #4
  %3 = load ptr, ptr @Renderer, align 8, !tbaa !6
  %4 = tail call i32 @SDL_SetRenderDrawColor(ptr noundef %3, i8 noundef zeroext 0, i8 noundef zeroext 0, i8 noundef zeroext 0, i8 noundef zeroext 0) #4
  %5 = load ptr, ptr @Renderer, align 8, !tbaa !6
  %6 = tail call i32 @SDL_RenderClear(ptr noundef %5) #4
  %7 = tail call i64 @time(ptr noundef null) #4
  %8 = trunc i64 %7 to i32
  tail call void @srand(i32 noundef %8) #4
  %9 = load ptr, ptr @Renderer, align 8, !tbaa !6
  %10 = tail call i32 @SDL_SetRenderDrawColor(ptr noundef %9, i8 noundef zeroext 0, i8 noundef zeroext 0, i8 noundef zeroext 0, i8 noundef zeroext 0) #4
  %11 = load ptr, ptr @Renderer, align 8, !tbaa !6
  %12 = tail call i32 @SDL_RenderDrawPoint(ptr noundef %11, i32 noundef 0, i32 noundef 0) #4
  %13 = tail call i32 @SDL_GetTicks() #4
  store i32 %13, ptr @Ticks, align 4, !tbaa !11
  tail call void @simFlush()
  ret void
}

declare i32 @SDL_Init(i32 noundef) local_unnamed_addr #1

declare i32 @SDL_CreateWindowAndRenderer(i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef) local_unnamed_addr #1

declare i32 @SDL_SetRenderDrawColor(ptr noundef, i8 noundef zeroext, i8 noundef zeroext, i8 noundef zeroext, i8 noundef zeroext) local_unnamed_addr #1

declare i32 @SDL_RenderClear(ptr noundef) local_unnamed_addr #1

declare void @srand(i32 noundef) local_unnamed_addr #1

declare i64 @time(ptr noundef) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable(sync)
define void @simPutPixel(i32 noundef %0, i32 noundef %1, i32 noundef %2) local_unnamed_addr #0 {
  %4 = icmp ugt i32 %0, 799
  br i1 %4, label %5, label %6, !prof !13

5:                                                ; preds = %3
  tail call void @__assert_rtn(ptr noundef nonnull @__func__.simPutPixel, ptr noundef nonnull @.str.1, i32 noundef 51, ptr noundef nonnull @.str.4) #5
  unreachable

6:                                                ; preds = %3
  %7 = icmp ugt i32 %1, 599
  br i1 %7, label %8, label %9, !prof !13

8:                                                ; preds = %6
  tail call void @__assert_rtn(ptr noundef nonnull @__func__.simPutPixel, ptr noundef nonnull @.str.1, i32 noundef 52, ptr noundef nonnull @.str.5) #5
  unreachable

9:                                                ; preds = %6
  %10 = lshr i32 %2, 24
  %11 = trunc nuw i32 %10 to i8
  %12 = lshr i32 %2, 16
  %13 = trunc i32 %12 to i8
  %14 = lshr i32 %2, 8
  %15 = trunc i32 %14 to i8
  %16 = trunc i32 %2 to i8
  %17 = load ptr, ptr @Renderer, align 8, !tbaa !6
  %18 = tail call i32 @SDL_SetRenderDrawColor(ptr noundef %17, i8 noundef zeroext %13, i8 noundef zeroext %15, i8 noundef zeroext %16, i8 noundef zeroext %11) #4
  %19 = load ptr, ptr @Renderer, align 8, !tbaa !6
  %20 = tail call i32 @SDL_RenderDrawPoint(ptr noundef %19, i32 noundef %0, i32 noundef %1) #4
  %21 = tail call i32 @SDL_GetTicks() #4
  store i32 %21, ptr @Ticks, align 4, !tbaa !11
  ret void
}

; Function Attrs: nounwind ssp uwtable(sync)
define void @simExit() local_unnamed_addr #0 {
  %1 = alloca %union.SDL_Event, align 8
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %1) #4
  br label %2

2:                                                ; preds = %2, %0
  %3 = call i32 @SDL_PollEvent(ptr noundef nonnull %1) #4
  %4 = icmp ne i32 %3, 0
  %5 = load i32, ptr %1, align 8
  %6 = icmp eq i32 %5, 256
  %7 = select i1 %4, i1 %6, i1 false
  br i1 %7, label %8, label %2, !llvm.loop !14

8:                                                ; preds = %2
  %9 = load ptr, ptr @Renderer, align 8, !tbaa !6
  call void @SDL_DestroyRenderer(ptr noundef %9) #4
  %10 = load ptr, ptr @Window, align 8, !tbaa !16
  call void @SDL_DestroyWindow(ptr noundef %10) #4
  call void @SDL_Quit() #4
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %1) #4
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

declare i32 @SDL_PollEvent(ptr noundef) local_unnamed_addr #1

declare void @SDL_DestroyRenderer(ptr noundef) local_unnamed_addr #1

declare void @SDL_DestroyWindow(ptr noundef) local_unnamed_addr #1

declare void @SDL_Quit() local_unnamed_addr #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nounwind ssp uwtable(sync)
define void @simFlush() local_unnamed_addr #0 {
  tail call void @SDL_PumpEvents() #4
  %1 = tail call i32 @SDL_HasEvent(i32 noundef 256) #4
  %2 = icmp eq i32 %1, 1
  br i1 %2, label %3, label %4, !prof !13

3:                                                ; preds = %0
  tail call void @__assert_rtn(ptr noundef nonnull @__func__.simFlush, ptr noundef nonnull @.str.1, i32 noundef 40, ptr noundef nonnull @.str.2) #5
  unreachable

4:                                                ; preds = %0
  %5 = tail call i32 @SDL_GetTicks() #4
  %6 = load i32, ptr @Ticks, align 4, !tbaa !11
  %7 = sub i32 %5, %6
  %8 = icmp ult i32 %7, 50
  br i1 %8, label %9, label %11

9:                                                ; preds = %4
  %10 = sub nuw nsw i32 50, %7
  tail call void @SDL_Delay(i32 noundef %10) #4
  br label %11

11:                                               ; preds = %9, %4
  %12 = load ptr, ptr @Renderer, align 8, !tbaa !6
  tail call void @SDL_RenderPresent(ptr noundef %12) #4
  ret void
}

declare void @SDL_PumpEvents() local_unnamed_addr #1

declare i32 @SDL_HasEvent(i32 noundef) local_unnamed_addr #1

; Function Attrs: cold noreturn
declare void @__assert_rtn(ptr noundef, ptr noundef, i32 noundef, ptr noundef) local_unnamed_addr #3

declare i32 @SDL_GetTicks() local_unnamed_addr #1

declare void @SDL_Delay(i32 noundef) local_unnamed_addr #1

declare void @SDL_RenderPresent(ptr noundef) local_unnamed_addr #1

declare i32 @SDL_RenderDrawPoint(ptr noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable(sync)
define i32 @simRand() local_unnamed_addr #0 {
  %1 = tail call i32 @rand() #4
  ret i32 %1
}

declare i32 @rand() local_unnamed_addr #1

attributes #0 = { nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { cold noreturn "disable-tail-calls"="true" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #4 = { nounwind }
attributes #5 = { cold noreturn nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 20.1.5"}
!6 = !{!7, !7, i64 0}
!7 = !{!"p1 _ZTS12SDL_Renderer", !8, i64 0}
!8 = !{!"any pointer", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
!11 = !{!12, !12, i64 0}
!12 = !{!"int", !9, i64 0}
!13 = !{!"branch_weights", !"expected", i32 1, i32 2000}
!14 = distinct !{!14, !15}
!15 = !{!"llvm.loop.unroll.disable"}
!16 = !{!17, !17, i64 0}
!17 = !{!"p1 _ZTS10SDL_Window", !8, i64 0}
