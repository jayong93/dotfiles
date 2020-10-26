RUSTUP_PATH=$(which rustup)

if [ -z "${RUSTUP_PATH}" ]
then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
