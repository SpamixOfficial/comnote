<script lang="ts">
    let { children, data } = $props();
    import Icon from "@iconify/svelte";
    import "../app.css";
    import { fly } from "svelte/transition";

    //window.document.getElementsByTagName("html").item(0)?.setAttribute("data-theme", "comdark");
</script>

{#key data.url}
    <div in:fly={{ x: 200, duration: 300, delay: 300 }} out:fly={{ x: -200, duration: 300 }}>
        {@render children()}
    </div>
{/key}

<style lang="postcss">
    @reference "../app.css";
    :global(body) {
        @apply bg-base-100 w-full h-screen;
    }
</style>
