<script lang="ts">
    import { invoke } from "@tauri-apps/api/core";
    import { open_login } from "tauri-plugin-login-browser-api";
</script>

<main class="container">
    <div class="flex flex-col gap-5 h-screen w-screen p-5 justify-center items-center">
        <h1 class="font-bold text-5xl">ComNote</h1>
        <button
            class="btn btn-primary btn-block btn-lg"
            onclick={async () => {
                await open_login((x, e) => {console.log(x, e)});
            }}><p class="font-semibold">Login</p></button
        >
    </div>
</main>
