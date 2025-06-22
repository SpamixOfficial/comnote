<script lang="ts">
    import { invoke } from "@tauri-apps/api/core";
    import { onMount } from "svelte";
    let logged_in = $state(false);
    onMount(async () => {
        logged_in = await invoke("logged_in");
    })
</script>

<main class="container">
    <div class="flex flex-col gap-5 h-screen w-screen p-5 justify-center items-center">
        <a href="/login">{logged_in}</a>
    </div>
</main>