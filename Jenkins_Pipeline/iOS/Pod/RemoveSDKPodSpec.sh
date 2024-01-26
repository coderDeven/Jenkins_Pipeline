#!/bin/bash
# Purpose : 删除所有 SDK Pod Spec 

repo_list=`pod repo list`
repo_list=$(echo "${repo_list}" | tr '[:upper:]' '[:lower:]')
echo ${repo_list}

dev_pod="platform-sdk/centurygamesdkpodspecinternal.git"
prod_pod="bitbucket.org/funplus/centurygamesdkpodspec.git"
gitlab_public_pod="platform-sdk-ios-pod/centurygamesdkpodspecpublic.git"

## 删除 Gitlab Public Spec
if [[ $repo_list =~ $gitlab_public_pod ]]
then
    echo "本机 Pod Repo 存在 CenturyGameSDKPodSpecPublic -> 移除 Repo !" 
    updateOutput=`pod repo remove CenturyGameSDKPodSpecPublic`
    updateRes=$?
    if [[ $updateRes == 0 ]]
    then
        echo "remove CenturyGameSDKPodSpecPublic 执行成功"
    else
        echo "remove CenturyGameSDKPodSpecPublic 执行失败" 
    fi
fi

## 删除 Gitlab Internal Spec 
if [[ $repo_list =~ $dev_pod ]]
then
    echo "本机 Pod Repo 存在 CenturyGameSDKPodSpecInternal -> 移除 Repo !" 
    updateOutput=`pod repo remove CenturyGameSDKPodSpecInternal`
    updateRes=$?
    if [[ $updateRes == 0 ]]
    then
        echo "remove CenturyGameSDKPodSpecInternal 执行成功"
    else
        echo "remove CenturyGameSDKPodSpecInternal 执行失败" 
    fi
fi

## 删除 Bitbucket Prod Spec 
if [[ $repo_list =~ $prod_pod ]]
then
    echo "本机 Pod Repo 存在 CenturyGameSDKPodSpec -> 移除 Repo !" 
    updateOutput=`pod repo remove CenturyGameSDKPodSpec`
    updateRes=$?
    if [[ $updateRes == 0 ]]
    then
        echo "remove CenturyGameSDKPodSpec 执行成功"
    else
        echo "remove CenturyGameSDKPodSpec 执行失败" 
    fi
fi
