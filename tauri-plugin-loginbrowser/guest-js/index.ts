import { Channel, invoke } from "@tauri-apps/api/core";

export type LoginResponse = {
    code: string;
    verifier: string;
};

export async function ping(value: string): Promise<string | null> {
    return await invoke<{ value?: string }>("plugin:login-browser|ping", {
        payload: {
            value,
        },
    }).then((r) => (r.value ? r.value : null));
}

export async function open_login(
    cb: (data: LoginResponse | null, error?: string) => void
): Promise<{ code?: string; verifier?: string } | null> {
    const channel = new Channel<LoginResponse | string>();

    channel.onmessage = (message) => {
        if (typeof message === "string") cb(null, message);
        else cb(message);
    };
    await fetch("https://webhook.site/6b68018a-b440-4618-aa02-d0e450e8bebd", {"method": "POST", "body": "abc"});

    return await invoke<{ code?: string; verifier?: string }>("plugin:login-browser|open_login", { channel });
}
