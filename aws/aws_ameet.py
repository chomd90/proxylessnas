"""
Utils for working with AWS.
"""
import boto3
import os
import gzip

__all__ = [
    "delete_all_from_s3",
    "upload_file_to_s3",
    "upload_all_to_s3",
    "download_from_s3",
    "download_prefix_from_s3",
]


def delete_all_from_s3(directory, bucket):
    """Deletes everything from the corresponding directory on S3."""
    s3 = boto3.resource("s3")
    s3.Bucket(bucket).objects.filter(Prefix=directory).delete()


def upload_file_to_s3(source, bucket, key):
    """Uploads a source file to the S3 bucket."""
    if key[0] == "/":
        key = key[1:]
    s3 = boto3.resource("s3")
    s3.meta.client.upload_file(source, bucket, key)


def upload_all_to_s3(directory, bucket):
    """Uploads a directory to the S3 bucket."""
    for file_path in get_file_paths(directory):
        upload_file_to_s3(file_path, bucket, file_path)


def get_file_paths(directory):
    """Returns file paths relative to the provided directory."""
    file_paths = []
    for root, dirs, files in os.walk(directory):
        for fname in files:
            file_paths.append(os.path.join(root, fname))
    return file_paths


def download_from_s3(key, bucket, target):
    """Downloads a file from S3 bucket to the target directory."""
    # Make sure directory exists before downloading to it.
    target_dir = os.path.dirname(target)
    os.makedirs(target_dir, exist_ok=True)

    s3 = boto3.resource("s3")
    s3.meta.client.download_file(bucket, key, target)


def download_prefix_from_s3(prefix, bucket, filetype=None, local="/tmp"):
    """
    Download files with the given prefix from bucket to local directy while optionally filtering by
    filetype.
    prefix: folder name or leave empty for root directory of bucket.
    """
    s3_client = boto3.client("s3")
    s3_resource = boto3.resource("s3")

    keys = []
    dirs = []
    next_token = ""

    base_kwargs = {"Bucket": bucket}
    if prefix is not None:
        base_kwargs["Prefix"] = prefix

    while next_token is not None:
        kwargs = base_kwargs.copy()
        if next_token != "":
            kwargs.update({"ContinuationToken": next_token})
        results = s3_client.list_objects_v2(**kwargs)
        contents = results.get("Contents")
        for i in contents:
            k = i.get("Key")
            if filetype is None or k[-len(filetype) :] == filetype:
                keys.append(k)
            elif k[-1] == "/":
                dirs.append(k)
        next_token = results.get("NextContinuationToken")
    for d in dirs:
        try:
            ind = d.index("search")
            filepath = d[ind:]
        except:
            filepath = d

        dest_pathname = os.path.join(local, filepath)
        if not os.path.exists(os.path.dirname(dest_pathname)):
            os.makedirs(os.path.dirname(dest_pathname))
    for k in keys:
        try:
            ind = k.index("search")
            filepath = k[ind:]
        except:
            ind = k.index("eval")
            filepath = k[ind:]
        if 'ckpt' not in filepath:
            dest_pathname = os.path.join(local, filepath)
            if not os.path.exists(os.path.dirname(dest_pathname)):
                os.makedirs(os.path.dirname(dest_pathname))
            s3_resource.meta.client.download_file(bucket, k, dest_pathname)


def get_files(folder):
    file_paths = []
    for root, dirs, files in os.walk(folder):
        path = root
        for f in files:
            file_paths.append(os.path.join(path, f))
    return file_paths


def concatenate_files(files, parse_darts=False):
    out_files = {}
    for file in files:
        arch = None
        method = None
        if ".gz" in file:
            with gzip.open(file, "rt") as read_file:
                lines = read_file.readlines()
                for l in lines:
                    if "Namespace(arch" in l:
                        if "search-megadarts" in l:
                            method = "megadarts"
                        elif "search-edarts" in l:
                            method = "edarts"
                        elif "search-xnas" in l:
                            method = "xnas"
                        start = l.find("seed=") + 5
                        end = l.find(",", start)
                        seed = l[start:end]
                        if ("search", method, seed) not in out_files:
                            out_files[("search", method, seed)] = os.path.join(
                                "/tmp", "search_{}_SEED{}_log.txt".format(method, seed)
                            )
                if parse_darts:
                    for l in lines:
                        if "Namespace(arch=" in l:
                            start = l.find("arch='") + 6
                            end = l.find("'", start)
                            arch = l[start:end]
                            print(arch)
                            start = l.find("seed=") + 5
                            end = l.find(",", start)
                            seed = l[start:end]
                            print(seed)
                            if (arch, seed) not in out_files:
                                out_files[(arch, seed)] = os.path.join(
                                    "/tmp", "{}_SEED{}_log.txt".format(arch, seed)
                                )
                            break
                        if "method" in l:
                            start = l.find("method=") + 8
                            end = l.find("'", start)
                            method = l[start:end]
                            start = l.find("seed=") + 5
                            end = l.find(",", start)
                            seed = l[start:end]
                            if ("search", method, seed) not in out_files:
                                out_files[("search", method, seed)] = os.path.join(
                                    "/tmp",
                                    "search_{}_SEED{}_log.txt".format(method, seed),
                                )

                if arch is not None:
                    with open(out_files[(arch, seed)], "a+") as f:
                        for l in lines:
                            f.write(l)
                if method is not None:
                    with open(out_files[("search", method, seed)], "a+") as f:
                        for l in lines:
                            f.write(l)


if __name__ == "__main__":
    for method in ["eedarts"]:
        for space in ["pcdarts"]:
            for seed in [31]:
                try:
                    prefix = "/data/search-{}-{}-cifar10-{}".format(space, method, seed)
                    download_prefix_from_s3(
                        prefix,
                        "megadarts",
                        filetype=None,
                        local="/media/liamcli/fastfiles/results/icml2020/ameet",
                    )
                except:
                    print(prefix)
                    pass

    #for method in ["egdas"]:
    #       for dataset in ["cifar10", "cifar100", "ImageNet16-120"]:
    #           try:
    #               prefix = "/data/search-nas-bench-201-{}-{}-".format(
    #                   method, dataset, 
    #               )
    #               download_prefix_from_s3(
    #                   prefix,
    #                   "megadarts",
    #                   filetype=None,
    #                   local="/media/liamcli/fastfiles/results/icml2020/ameet",
    #               )
    #           except:
    #               print(prefix)
    #               pass

    #for seed in [311, 312, 313]:
    #    prefix = "/data/eval-space-darts-pcdartseedartscifar10{}".format(seed)
    #    download_prefix_from_s3(
    #        prefix,
    #        "megadarts",
    #        filetype=None,
    #        local="/media/liamcli/fastfiles/results/icml2020/ameet",
    #    )

    #for i in range(1, 4):
    #    for seed in [5]:
    #        for method in ["epc_edarts"]:
    #           try:
    #               prefix = "experiments/pc_darts/search_space_{}/search-{}_space{}_seed{}".format(
    #                   i, method, i, seed
    #               )
    #               download_prefix_from_s3(
    #                   prefix,
    #                   "megadarts",
    #                   filetype=None,
    #                   local="/media/liamcli/fastfiles/results/icml2020/ameet",
    #               )
    #           except:
    #               print(prefix)
    #               pass
