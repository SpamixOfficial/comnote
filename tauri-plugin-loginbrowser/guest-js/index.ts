import { invoke } from "@tauri-apps/api/core";

export async function ping(value: string): Promise<string | null> {
    return await invoke<{ value?: string }>("plugin:login-browser|ping", {
        payload: {
            value,
        },
    }).then((r) => (r.value ? r.value : null));
}

export async function open_login(): Promise<string | null> {
    return await invoke<{ code?: string }>("plugin:login-browser|open_login", {}).then((r) =>
        r.code ? r.code : null
    );
}
