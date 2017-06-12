from setuptools import setup

setup(
    name='xontrib-fzf-widgets',
    version='0.0.2',
    url='https://github.com/shahinism/xontrib-fzf-widgets',
    license='GPLv3',
    author='Shahin Azad',
    author_email='me@5hah.in',
    description="fzf widgets for xonsh",
    packages=['xontrib'],
    package_dir={'xontrib': 'xontrib'},
    package_data={'xontrib': ['*.xsh']},
    platforms='any',
    classifiers=[
        'Environment :: Console',
        'Intended Audience :: End Users/Desktop',
        'Operating System :: OS Independent',
        'Programming Language :: Python',
        'Topic :: Desktop Environment',
        'Topic :: System :: Shells',
        'Topic :: System :: System Shells',
    ]
)
