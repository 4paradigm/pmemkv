# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import subprocess
import os
from tabulate import tabulate

def execute_cmd_realtime(cmd, shell=True):
    child = subprocess.Popen(
        cmd, stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        shell=shell)

    while True:
        out = child.stdout.readline()
        pout = child.poll()
        if (not out) and pout is not None:
            break

        out = out.strip()
        if out:
            yield out.decode('utf-8')


def execute_cmd(cmd, shell=True):
    child = subprocess.Popen(
        cmd, stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        shell=shell)

    out, err = child.communicate()
    if out is not None:
        out = out.decode('utf-8')
    if err is not None:
        err = err.decode('utf-8')

    return out, err

def init_conf(pmem_path="/pmem"):
    cmd = "./init_conf.sh {}".format(pmem_path)
    for line in execute_cmd_realtime(cmd):
        print(line)

def start_rtidb():
    cmd = "./start_rtidb.sh"
    for line in execute_cmd_realtime(cmd):
        print(line)

def init_dram_table(thread_num=20, loop_count=1000000):
    cmd = "./init-dram-table.sh {} {}".format(thread_num, loop_count)
    for line in execute_cmd_realtime(cmd):
        if ("summary =" in line) or ("[INFO]" in line):
            print(line)

def init_pmem_table(thread_num=20, loop_count=1000000):
    cmd = "./init-pmem-table.sh {} {}".format(thread_num, loop_count)
    for line in execute_cmd_realtime(cmd):
        if ("summary =" in line) or ("[INFO]" in line):
            print(line)

def test_dram_get(thread_num=1, key_count=20000000):
    cmd = "./test-dram-get.sh {} {}".format(thread_num, key_count)
    for line in execute_cmd_realtime(cmd):
        if ("summary =" in line) or ("[INFO]" in line):
            print(line)

def test_pmem_get(thread_num=1, key_count=20000000):
    cmd = "./test-pmem-get.sh {} {}".format(thread_num, key_count)
    for line in execute_cmd_realtime(cmd):
        if ("summary =" in line) or ("[INFO]" in line):
            print(line)

def stop_rtidb():
    cmd = "./stop_rtidb.sh"
    for line in execute_cmd_realtime(cmd):
        print(line)

def check_recovery_time():
    cmd = "./check-recovery-time.sh"
    for line in execute_cmd_realtime(cmd):
        print(line)

def clear_rtidb():
    cmd = "./clear_rtidb.sh"
    for line in execute_cmd_realtime(cmd):
        print(line)
		