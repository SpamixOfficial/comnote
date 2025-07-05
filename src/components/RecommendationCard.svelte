<script lang="ts">
    import type {AnimeSummary} from "../lib/models";

    type Props = {
        theme: string,
        card_data: AnimeSummary
    }

    const { theme = $bindable(), card_data }: Props = $props();
    let image_loaded = $state(false);
</script>

<!-- Main Box -->
<div
    class="bg-base-200 inline-flex justify-start items-start gap-5 overflow-hidden px-7 py-5 rounded-3xl min-w-980/1080 min-h-400/2400 shadow-[0px_8px_4px_0px_rgba(0,0,0,0.51)]"
>
    <div
        class="w-60 h-96 relative bg-white/0 rounded-2xl shadow-[0px_4px_4px_0px_rgba(0,0,0,0.50)] outline-4 outline-base-300 overflow-hidden"
    >   
        {#if !image_loaded}
            <span class="absolute loading loading-ring loading-xs"></span>
        {/if}
        <!-- svelte-ignore a11y_img_redundant_alt -->
        <img onload={() => {image_loaded = true}} src={card_data.main_picture.large} alt="Poster image">
</div>
</div>
