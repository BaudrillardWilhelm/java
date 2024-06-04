package com.qdu.util;

import com.oreilly.servlet.multipart.FileRenamePolicy;
import java.io.File;
import java.util.UUID;

/**
 * 自定义上传文件的命名策略：针对一次上传一个文件
 *
 * @author Anna
 */
public class CustomFileRenamePolicy1 implements FileRenamePolicy {

    @Override
    public File rename(File file) {

        String fileName = file.getName();
        String extensionName = fileName.substring(fileName.lastIndexOf("."));
        String newName = UUID.randomUUID().toString().replace("-", "") + extensionName;
        File newFile = new File(file.getParent(), newName);
        return newFile;
    }

    public static void main(String[] args) {
        File file = new File("c:/photo/pic1.jpg");
        CustomFileRenamePolicy1 policy = new CustomFileRenamePolicy1();
        File newFile = policy.rename(file);
        System.out.println(newFile.getName());
    }

}
