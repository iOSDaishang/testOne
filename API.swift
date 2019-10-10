//
//  API.swift
//  EQS
//
//  Created by XL on 2018/11/6.
//  Copyright © 2018年 ShuXun. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
import RxSwift
import Alamofire
import Zip
import HandyJSON
class API {
    
    class func requestSingle<T: TargetType, H: HandyJSON>(_ type: T, _ model: H.Type, showLoading: Bool = false) ->  Single<H> {
        if showLoading {
            SwiftProgressHUD.hideAllHUD()
            //            SwiftProgressHUD.showWait()
            SwiftProgressHUD.showADMSHXLoading()
        }
        
        let ob = provider
            .rx.request(MultiTarget(type))
            .mapModel(model)
            .debug()
            .do(onSuccess: { _ in
                if showLoading {
                    SwiftProgressHUD.hideAllHUD()
                }
            }, onError: { (_) in
                if showLoading {
                    SwiftProgressHUD.hideAllHUD()
                }
            })
        return ob//.asObservable()
    }
    
    
    class func request<T: TargetType, H: HandyJSON>(_ type: T, _ model: H.Type, showLoading: Bool = false) ->  Observable<H> {
        if showLoading {
            SwiftProgressHUD.hideAllHUD()
            //            SwiftProgressHUD.showWait()
           SwiftProgressHUD.showADMSHXLoading()
        }
        
        let ob = provider
            .rx.request(MultiTarget(type))
            .mapModel(model)
            .debug()
            .do(onSuccess: { _ in
                if showLoading {
                    SwiftProgressHUD.hideAllHUD()
                }
            }, onError: { (_) in
                if showLoading {
                    SwiftProgressHUD.hideAllHUD()
                }
            })
        return ob.asObservable()
        
    }
    
    class func requestOther<T: TargetType, H: HandyJSON>(_ type: T, _ model: H.Type, showLoading: Bool = false) ->  Observable<H> {
        if showLoading {
            SwiftProgressHUD.hideAllHUD()
            //            SwiftProgressHUD.showWait()
            SwiftProgressHUD.showADMSHXLoading()
        }
        
        let ob = otherProvider
            .rx.request(MultiTarget(type))
            .mapModel(model)
            .debug()
            .do(onSuccess: { _ in
                if showLoading {
                    SwiftProgressHUD.hideAllHUD()
                }
            }, onError: { (_) in
                if showLoading {
                    SwiftProgressHUD.hideAllHUD()
                }
            })
        return ob.asObservable()
        
    }
    
    
    
    class func request<T: TargetType>(_ type: T, showLoading: Bool = false) ->  Observable<String> {
        if showLoading {
            SwiftProgressHUD.hideAllHUD()
            //            SwiftProgressHUD.showWait()
           SwiftProgressHUD.showADMSHXLoading()
        }
        
        let ob = provider
            .rx.request(MultiTarget(type))
            .mapString()
            .debug()
            .do(onSuccess: { _ in
                if showLoading {
                    SwiftProgressHUD.hideAllHUD()
                }
            }, onError: { (_) in
                if showLoading {
                    SwiftProgressHUD.hideAllHUD()
                }
            })
        
        return ob.asObservable()
    }
    
    
    class func downLoadRequest(asset: AssetProvider, model: HandyJSON.Type, completion: ((DownLoadModel) -> Void)? = nil, showLoading: Bool = false) {
        if showLoading {
            SwiftProgressHUD.hideAllHUD()
            //            SwiftProgressHUD.showWait()
           SwiftProgressHUD.showADMSHXLoading()
        }
        assetProvider.request(MultiTarget(asset)) { result in
            switch result {
            case .success:
                let model = DownLoadModel()
                model.localLocation = asset.localLocation.path
                model.assetName = asset.assetName
                model.success  = true
                completion?(model)
                if showLoading {
                    SwiftProgressHUD.hideAllHUD()
                }
            case let .failure(error):
                let model = DownLoadModel()
                model.success  = false
                model.errorString = error.errorDescription ?? ""
                completion?(model)
                if showLoading {
                    SwiftProgressHUD.hideAllHUD()
                }
            }
        }
        
    }
    
    class func downLoadRXRequest(asset: AssetProvider, model: HandyJSON.Type, showLoading: Bool = false) ->Observable<DownLoadModel> {
        if showLoading {
            SwiftProgressHUD.hideAllHUD()
            //            SwiftProgressHUD.showWait()
            SwiftProgressHUD.showADMSHXLoading()
        }
        let ob = assetProvider.rx.request(MultiTarget(asset))
            .mapDownLoadModel(asset: asset)
            .debug()
            .observeOn(MainScheduler.instance)
            .do(onSuccess: { _ in
                if showLoading {
                    SwiftProgressHUD.hideAllHUD()
                }
            }, onError: { (_) in
                if showLoading {
                    SwiftProgressHUD.hideAllHUD()
                }
            })
        
        return ob.asObservable()
    }
    
    //H5资源文件下载进度
    class func downloadProgressRXRequest(asset: AssetProvider, model: HandyJSON.Type, showLoading: Bool = false) ->Observable<DownLoadModel>  {
        if showLoading {
            SwiftProgressHUD.hideAllHUD()
            SwiftProgressHUD.showADMSHXLoading()
        }
        
        let ob = assetProvider.rx.requestWithProgress(MultiTarget(asset)).flatMap{ (progressResponse) -> Observable<DownLoadModel> in
            
                let downloadModel = DownLoadModel()
                downloadModel.localLocation = asset.localLocation.path
                downloadModel.assetName = asset.assetName
            
                if progressResponse.progressObject == nil{
                     downloadModel.success = false
                    return Observable.just(downloadModel)
                }
            
                let downloadSourceSize : Int = SXAuthCache.shared.h5SourceSubmitModel!.size
            var progressValue:CGFloat = CGFloat(progressResponse.progressObject?.completedUnitCount ?? 0) / CGFloat(downloadSourceSize)
                if progressValue > 0.989{
                    progressValue = 0.99
                }
                downloadModel.progress =  progressValue
            
                SXLog(" ========== ")
                SXLog("+++downloadProgressValue+++ \(progressResponse.progressObject?.completedUnitCount)")
                SXLog("+++downloadProgressValue+++ \(downloadModel.progress)")
                SXLog(" ========== ")
            
                if progressResponse.response == nil{
                    
                    downloadModel.success = false
                    
                     return Observable.just(downloadModel)
                }else{
                    
                    downloadModel.success = false
                    
                    if progressResponse.response?.statusCode == 200{
                        SXLog("+++downloadProgressValue+++ statusCode == 200 ")
                        downloadModel.success = true
                        downloadModel.progress = 1
                    }
                     downloadModel.statusCode = progressResponse.response!.statusCode
                     return Observable.just(downloadModel)
                }
            
            
            
            }.debug()
            .do(onNext: { _ in
                if showLoading {
                    SwiftProgressHUD.hideAllHUD()
                }
            }, onError: { (_) in
                if showLoading {
                    SwiftProgressHUD.hideAllHUD()
                }
            })
        
        return ob.asObservable()
        
        
    }
    
    class func uploadRXRequest<T: TargetType, H: UpLoadModel>(_ type: T, _ model: H.Type, showLoading: Bool = false) -> Observable<UpLoadModel> {
        var startTime:TimeInterval = Date().timeIntervalSince1970
        var currentEndTime:TimeInterval = 0
        var difference:TimeInterval = 5
        var speed:Double = 0
        if showLoading {
            SwiftProgressHUD.hideAllHUD()
            //            SwiftProgressHUD.showWait()
            SwiftProgressHUD.showADMSHXLoading()
        }
        //        (asset: AssetProvider, model: HandyJSON.Type, showLoading: Bool = false) {
        let ob = assetProvider.rx.requestWithProgress(MultiTarget(type)).flatMap { (progressResponse) -> Observable<UpLoadModel> in
            
            if progressResponse.progressObject == nil {
                let upLoadModel:UpLoadModel = UpLoadModel()
                
                upLoadModel.success = false
                return Observable.just(upLoadModel)
            } else {
                
                
                if currentEndTime > 0 && currentEndTime - startTime >= difference   {
                    difference = currentEndTime - startTime
                    startTime = currentEndTime
                }
                
                currentEndTime = Date().timeIntervalSince1970
                
                SXLog("+++++++++++" + "\(difference)")
                
               
                if !progressResponse.completed {//上传中
             
                    speed =  Double(progressResponse.progressObject?.completedUnitCount ?? 0)/(difference*1024)
                    var speedStr = ""
                    if speed >= 1024 {
                        speedStr = "\(Int(speed/1024))M/s"
                    } else {
                        speedStr = "\(Int(speed))K/s"
                    }
                    
                    SXLog("currentEndTime\(currentEndTime)\n--startTime\(startTime)\n-----speed\(String(describing: speed))\n-----progress\(Int(progressResponse.progress * 100))\n---difference\(difference)\n------completedUnitCount\(String(describing: progressResponse.progressObject?.completedUnitCount))\n------totalUnitCount\(String(describing: progressResponse.progressObject?.totalUnitCount))\n----\(speedStr)")
                    
                    let upLoadModel:UpLoadModel = UpLoadModel()
                    upLoadModel.success = true
                    upLoadModel.data.isUploadFinished = progressResponse.completed
                    upLoadModel.data.progress = "\(Int(progressResponse.progress * 100))"
                    upLoadModel.data.speed = speedStr
                    upLoadModel.data.uploadStatus = 1
                    return Observable.just(upLoadModel)
                } else  {
                    let tmpLoadModel = try? progressResponse.mapUpLoadModel(model)
                    let upLoadModel:UpLoadModel = tmpLoadModel ?? UpLoadModel()
                    upLoadModel.data.isUploadFinished = progressResponse.completed
                    upLoadModel.data.progress = "\(Int(progressResponse.progress * 100))"
                    if upLoadModel.success && upLoadModel.data.isUploadFinished {
                        upLoadModel.data.uploadStatus = 3
                    } else {
                        upLoadModel.data.uploadStatus = 2
                        upLoadModel.data.uploadFailedDes = upLoadModel.msg.count > 0 ? upLoadModel.msg :"请求返回错误"
                    }
//                    upLoadModel.data.speed = speedStr
                    
                    if upLoadModel.code == "999999"   {
                        upLoadModel.msg = "当前系统繁忙，请重新尝试"
                        upLoadModel.success = false
                    }
                
                    return Observable.just(upLoadModel)
                }
            }
            
            
            
            }.debug()
            .do(onNext: { _ in
                if showLoading {
                    SwiftProgressHUD.hideAllHUD()
                }
            }, onError: { (_) in
                if showLoading {
                    SwiftProgressHUD.hideAllHUD()
                }
            })
        
        return ob.asObservable()
    }
}




