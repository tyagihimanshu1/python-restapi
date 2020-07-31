import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="csapiapp", # Replace with your own username
    version="0.0.1",
    author="Himanshu Tyagi",
    author_email="him@delcon.com",
    description="Words API",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://dev.azure.com/TH01codehub/CodeHub/_git/cloudsolutions",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
    ],
    python_requires='>=3.6',
)