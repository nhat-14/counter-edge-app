import datetime
import time
import subprocess

result = subprocess.run(["uname", "-r"], capture_output=True, text=True)
kernel_version = result.stdout.strip()

result = subprocess.run(["cat", "/sys/class/dmi/id/product_name"], capture_output=True, text=True)
edge_product_name = result.stdout.strip()

print(f"kernel_version: {kernel_version}")
print(f"edge_product_name: {edge_product_name}")

print("Starting the program. If stopping, please press Ctrl+C")

try:
    while True:
        # now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")          # v1.0.0
        now = datetime.datetime.now().strftime("%Y年%-m月%-d日 %H時%M分%S秒")   # v2.0.0
        print(f"Now: {now}")
        time.sleep(5)

except KeyboardInterrupt:
    print("\nStopped")