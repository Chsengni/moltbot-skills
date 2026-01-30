const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');

/**
 * 执行清理C盘脚本的函数
 */
function executeCleanupScript() {
  return new Promise((resolve, reject) => {
    // 确保在Windows环境下运行
    if (process.platform !== 'win32') {
      reject(new Error('此脚本只能在Windows系统上运行'));
      return;
    }

    // 获取脚本路径
    const scriptPath = path.join(__dirname, 'scripts', 'disk-cleanup.bat');
    
    // 检查脚本是否存在
    if (!fs.existsSync(scriptPath)) {
      reject(new Error(`脚本文件不存在: ${scriptPath}`));
      return;
    }

    console.log('正在启动清理C盘脚本...');
    console.log('注意：脚本将以管理员权限运行，请在系统提示时确认授权。');

    // 执行批处理脚本
    const childProcess = exec(
      `start cmd /c "${scriptPath}"`,
      { windowsHide: false },
      (error, stdout, stderr) => {
        if (error) {
          reject(new Error(`执行失败: ${error.message}`));
          return;
        }
        
        resolve({
          success: true,
          message: '清理脚本已成功启动',
          stdout: stdout || '无输出',
          stderr: stderr || '无错误输出'
        });
      }
    );

    // 监听进程事件
    childProcess.on('error', (err) => {
      reject(new Error(`进程错误: ${err.message}`));
    });

    childProcess.on('spawn', () => {
      console.log('清理进程已启动');
    });
  });
}

// 如果直接运行此文件
if (require.main === module) {
  executeCleanupScript()
    .then(result => {
      console.log('脚本执行结果:', result);
    })
    .catch(error => {
      console.error('执行出错:', error.message);
    });
}

module.exports = { executeCleanupScript };