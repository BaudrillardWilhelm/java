package com.qdu.util;

import com.oreilly.servlet.multipart.FileRenamePolicy;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * 自定义上传文件的命名策略：针对一次上传多个文件
 *
 * @author Anna
 */
public class CustomFileRenamePolicy2 implements FileRenamePolicy {

    private List<String> fileNames=new ArrayList<>();
    
    @Override
    public File rename(File file) {

        String fileName = file.getName();
        String extensionName = fileName.substring(fileName.lastIndexOf("."));
        String newName = UUID.randomUUID().toString().replace("-", "") + extensionName;
        fileNames.add(newName);
        File newFile = new File(file.getParent(), newName);
        return newFile;
    }

    public List<String> getFileNames() {
        return fileNames;
    }
}
