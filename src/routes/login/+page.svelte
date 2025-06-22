<script lang="ts">
    import Icon from "@iconify/svelte";
    import { invoke } from "@tauri-apps/api/core";
    import { open_login } from "tauri-plugin-login-browser-api";
    let failure = $state(false);
    let error_message = $state("");
</script>

<main class="container">
    <div class="flex flex-col gap-5 w-screen p-2 items-center">
        {#if failure}
            <div role="alert" class="min-w-full alert alert-error bg-base-200 border-2 shadow-error shadow-lg/50">
                <Icon icon="material-symbols:error" width="24" height="24" class="mb-1" />
                <span>Login failed: <code class="font-mono bg-">{error_message}</code></span>
            </div>
        {/if}
    </div>
    <div class="flex flex-col gap-5 h-screen w-screen p-5 justify-center items-center">
        <h1 class="font-bold text-5xl">ComNote</h1>
        <button
            class="btn btn-primary btn-block btn-lg shadow-primary shadow-xl/30"
            onclick={async () => {
                await open_login(async (x, e) => {
                    if (x === null || x?.code == "failure") {
                        failure = true;
                        error_message = e ?? "Unknown Error";
                        return;
                    }
                    await invoke("login", x);  
                });
            }}><Icon icon="material-symbols:login" width="24" height="24" class="mb-1" /><p class="font-semibold">Login</p></button
        >
    </div>
</main>
