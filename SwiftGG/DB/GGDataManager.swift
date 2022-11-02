//
//  GGDataManager.swift
//  SwiftGG
//
//  Created by stoicer on 2022/11/2.
//

import Foundation

let kGGToken = "kGGToken"
let kGGUserName = "kGGUserName"
let kGGAvatar = "kGGAvatar"
let kGGName = "kGGName"
let kImState = "kImState"
let kFreeDesk = "kFreeDesk"

let userDefault = UserDefaults.standard

class GGDataManager
{

    class func saveUserInfo(dic: [String: AnyObject])
    {
        //token
        let token = dic["token"]
        let userName = dic["nick_name"]
        let avatarUrl = dic["avatar_url"]
        let name = dic["name"]
        let imState = dic["jg_im_enable"]
        let takenSystemDesk = dic["taken_sys_desktop"] as? Bool
        
        
        userDefault.set(token, forKey: kGGToken)
        userDefault.set(userName, forKey: kGGUserName)
        userDefault.set(avatarUrl, forKey: kGGAvatar)
        userDefault.set(name, forKey: kGGAvatar)
        userDefault.set(imState, forKey: kImState)
        userDefault.set(takenSystemDesk, forKey: kImState)

        /*
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:[data[@"taken_sys_desktop"]boolValue]] forKey:kFreeDesk];
        [[NSUserDefaults standardUserDefaults] setObject:data[@"jg_im_uname"] forKey:kIMAccount];
        [[NSUserDefaults standardUserDefaults] setObject:data[@"jg_im_pwd"] forKey:kIMPwd];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",data[@"grade"]] forKey:kIsVIP];
        [[NSUserDefaults standardUserDefaults] setObject:data[kNickName_list] forKey:kNickName_list];
        POTemplateEntity *temp = [POTemplateEntity yy_modelWithJSON:data[@"template_info"]];
        NSData *tempData = [NSKeyedArchiver archivedDataWithRootObject:temp];
        [[NSUserDefaults standardUserDefaults] setObject:tempData forKey:kTemplateInfoCache];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSDictionary *dic = data[@"sys_props"];
        
        [[NSUserDefaults standardUserDefaults] setObject:[dic deleteNull] forKey:kUserSysInfo];
        
        //用户购买或加入的公司（公服版才有用）
        NSArray *branchCompaniesArr = data[@"branchCompanies"];
        [[NSUserDefaults standardUserDefaults] setObject:branchCompaniesArr forKey:kBranchCompaniesInfo];
        
        //用户认证方式:个人认证或企业认证（公服版才有用）
        if ([branchCompaniesArr isKindOfClass:[NSArray class]] && branchCompaniesArr.count > 0)
        {
            NSDictionary *dict = branchCompaniesArr.firstObject;
            NSNumber *authenticationModel = dict[@"authenticationModel"];
            if (authenticationModel)
            {
                [[NSUserDefaults standardUserDefaults] setObject:authenticationModel forKey:kPublicAuthenticationMode];
            }
            
            //是否重新发起合同签署 合同认证是否通过 1、通过，2、不通过。不通过时候，需要重新签署
            NSNumber *contractSignFlag = dict[@"contractPass"];
            NSString *signName = dict[@"signName"] ? : @"";
            if ([contractSignFlag integerValue] == 2 && [GetIMAccount isEqualToString:signName])
            {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kPublicContractSign];
            }
            else
            {
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kPublicContractSign];
            }
        }
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        [PODataManager saveAuthority:data[@"auth_list"]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kDidSaveUserInfo" object:nil];
        */
        
        
    }
}


