import redis, os, io, time

redis_pass = os.environ['PASSWD']
r=redis.StrictRedis(host='127.0.0.1',password=redis_pass)
file_path = "/tmp/health/health"
directory = os.path.dirname(file_path)

def touch_file():
    if not os.path.exists(directory):
        os.makedirs(directory)
    with io.open(file_path, 'ab'):
        os.utime(file_path, None)

def remove_file():
    try:
        os.remove(file_path)
    except:
        pass

if __name__ == "__main__":
    while True:
        time.sleep(1)
        try:
            r.ping()
            touch_file()
        except:
            remove_file()
