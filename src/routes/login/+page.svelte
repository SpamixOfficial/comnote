<script lang="ts">
    import Icon from "@iconify/svelte";
    import { invoke } from "@tauri-apps/api/core";
    import { onMount } from "svelte";
    import { open_login } from "tauri-plugin-login-browser-api";
    let failure = $state(false);
    let logged_in = $state(false);
    let success = $state(false);
    let error_message = $state("");

    onMount(async () => {
        logged_in = await invoke("logged_in");
    })
</script>

<main class="container">
    <div class="flex fixed flex-col gap-5 w-screen p-2 pt-7 items-center">
        {#if failure}
            <div role="alert" class="min-w-full alert alert-error bg-base-200 border-2 shadow-error shadow-lg/50">
                <Icon icon="material-symbols:error" width="24" height="24" class="mb-1" />
                <span>Login failed: <code class="font-mono bg-">{error_message}</code></span>
            </div>
        {:else if success}
            <div role="alert" class="min-w-full alert alert-success bg-base-200 border-2 shadow-success shadow-lg/50">
                <Icon icon="material-symbols:error" width="24" height="24" class="mb-1" />
                <span>🎉 You're logged in! You may continue using the app as-is, but it is recommended to restart</span>
            </div>
        {/if}
    </div>
    <div class="flex flex-col gap-5 h-screen w-screen p-5 justify-center items-center">
        <h1 class="font-bold text-5xl">ComNote</h1>
        <button
            class="btn btn-primary btn-block btn-lg shadow-primary shadow-xl/30"
            disabled={logged_in}
            onclick={async () => {
                await open_login(async (x, e) => {
                    if (x === null || x?.code == "failure") {
                        failure = true;
                        error_message = e ?? "Unknown Error";
                        return;
                    }
                    await invoke("login", x);
                    logged_in = await invoke("logged_in");
                    success = logged_in;
                });
            }}
            ><Icon icon="material-symbols:login" width="24" height="24" class="mb-1" />
            {#if !logged_in}
                <p class="font-semibold">Login</p>
            {:else}
                <p class="font-semibold">Logged In</p>
            {/if}
        </button>
    </div>
</main>
