<script lang="ts">
    import Icon from "@iconify/svelte";
    import { invoke } from "@tauri-apps/api/core";
    import { onMount } from "svelte";
    import RecommendationCard from "../components/RecommendationCard.svelte";
    import type { AnimeResponse, AnimeSummary } from "$lib/models";

    let logged_in = $state(false);
    let refresh_state = $state({
        success: false,
        failure: false,
        error: "None :D",
    });

    let just_added_data: AnimeSummary[] = $state([]);

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

        let resp: AnimeResponse = await invoke("get_just_added", { limit: 10, offset: 0 });
        just_added_data = resp.data.map((x) => x.node)
    });
</script>

<main class="container">
    <div class="flex fixed flex-col gap-5 w-screen px-2 pt-7 items-center">
        {#if refresh_state.failure}
            <div role="alert" class="min-w-full alert alert-error bg-base-200 border-2 shadow-error shadow-lg/50">
                <Icon icon="material-symbols:error" width="24" height="24" class="mb-1 text-error" />
                <span class="text-base-content"
                    >Token refresh failed: <code class="font-mono bg-base-300">{refresh_state.error}</code></span
                >
            </div>
        {/if}
    </div>
    <div class="flex flex-col gap-5 h-screen w-screen p-5 justify-center items-center">
        {#each just_added_data as item}
            <RecommendationCard theme={"light"} card_data={item}></RecommendationCard>
        {/each}
        <a href="/login">{logged_in}</a>
    </div>
</main>
