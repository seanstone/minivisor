Minimal Linux to serve as VM host

1. Install dependencies:

    * `crosstool-ng`
    * `nasm`, `iasl` for `ovmf`

2. Prepare

    ```shell
    $ make prep
    ```

3. Build toolchain:

    ```shell
    $ make ct-ng-build
    ```

4. Build system image:

    ```
    $ make
    ```
