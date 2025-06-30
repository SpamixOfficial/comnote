<script lang="ts">
    import Icon from "@iconify/svelte";
    import { invoke } from "@tauri-apps/api/core";
    import { onMount } from "svelte";
    
    let logged_in = $state(false);
    let refresh_state = $state({
        success: false,
        failure: false,
        error: "None :D",
    });

    onMount(async () => {
        logged_in = await invoke("logged_in");
        let has_session_expired = await invoke("session_expired");
        if (logged_in && has_session_expired) {
            try {
                await invoke("refresh_login");
                refresh_state.success = true;
            } catch (e: any) {
                refresh_state.failure = true;
                refresh_state.error = e as string;
            }
        }
    });
</script>

<main class="container">
    <div class="flex fixed flex-col gap-5 w-screen p-2 pt-7 items-center">
        {#if refresh_state.failure}
            <div role="alert" class="min-w-full alert alert-error bg-base-200 border-2 shadow-error shadow-lg/50">
                <Icon icon="material-symbols:error" width="24" height="24" class="mb-1 text-error" />
                <span class="text-base-content">Token refresh failed: <code class="font-mono bg-base-300">{refresh_state.error}</code></span>
            </div>
        {/if}
    </div>
    <div class="flex flex-col gap-5 h-screen w-screen p-5 justify-center items-center">
        <a href="/login">{logged_in}</a>
    </div>
</main>
