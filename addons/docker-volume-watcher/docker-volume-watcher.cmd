@ECHO OFF
REM ----------------------------------------------------------------------------
REM  J1: docker-volume-watcher.cmd
REM  Command wrapper to run docker-volume-watcher.exe
REM
REM  Product/Info:
REM  https://jekyll-one.com
REM
REM  J1 is distributed in the hope that it will be useful,but
REM  WITHOUT ANY WARRANTY; without even the  implied warranty
REM  of MERCHANTABILITY  or  FITNESS FOR A PARTICULAR PURPOSE.
REM
REM  J1 Template is licensed under the MIT License.
REM  See: https://github.com/jekyll-one/j1_template_mde/blob/master/LICENSE
REM
REM  Copyright (C) 2018 Juergen Adams
REM
REM ----------------------------------------------------------------------------
REM NOTE: For details on docker-volume-watcher see:
REM       http://blog.subjectify.us/miscellaneous/2017/04/24/docker-for-windows-watch-bindings.html
REM ----------------------------------------------------------------------------

REM base configuration
REM ----------------------------------------------------------------------------
SET WATCHER_LOG_PATH=log\volume-watcher.log

docker-volume-watcher.exe -v > %WATCHER_LOG_PATH% 2>&1




