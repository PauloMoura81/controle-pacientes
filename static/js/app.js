/**
 * Controle de Pacientes - JavaScript v1.1.0
 * - Toggle financial values visibility
 * - Sortable table columns
 * - Delete confirmation
 */

// ==================== TOGGLE FINANCIAL VALUES ====================

function toggleFinancial() {
    const elements = document.querySelectorAll('.financial-value');
    const btn = document.getElementById('toggle-financial');
    const isHidden = elements.length > 0 && elements[0].classList.contains('hidden-value');

    elements.forEach(el => {
        if (isHidden) {
            el.classList.remove('hidden-value');
            el.querySelectorAll('.mask').forEach(m => m.remove());
            // Restore original text
            if (el.dataset.original) {
                el.innerHTML = el.dataset.original;
                delete el.dataset.original;
            }
        } else {
            el.dataset.original = el.innerHTML;
            el.classList.add('hidden-value');
            el.innerHTML = '<span class="mask">••••••</span>';
        }
    });

    if (btn) {
        btn.innerHTML = isHidden
            ? '<span id="toggle-icon">&#128065;</span> Ocultar Valores'
            : '<span id="toggle-icon">&#128064;</span> Mostrar Valores';
    }

    // Persist preference
    localStorage.setItem('hideFinancial', isHidden ? 'false' : 'true');
}

// Apply saved preference on page load
document.addEventListener('DOMContentLoaded', function() {
    if (localStorage.getItem('hideFinancial') === 'true') {
        toggleFinancial();
    }
});


// ==================== SORTABLE TABLES ====================

document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.sortable-table').forEach(table => {
        const headers = table.querySelectorAll('th.sortable');
        headers.forEach(header => {
            header.addEventListener('click', function() {
                const colIndex = parseInt(this.dataset.col);
                const tbody = table.querySelector('tbody');
                const rows = Array.from(tbody.querySelectorAll('tr:not(.total-row)'));
                const totalRow = tbody.querySelector('tr.total-row');

                // Determine sort direction
                const currentDir = this.dataset.sortDir || 'none';
                const newDir = currentDir === 'asc' ? 'desc' : 'asc';

                // Reset all headers in this table
                headers.forEach(h => {
                    h.dataset.sortDir = 'none';
                    h.querySelector('.sort-icon').textContent = '';
                });

                this.dataset.sortDir = newDir;
                this.querySelector('.sort-icon').textContent = newDir === 'asc' ? ' ▲' : ' ▼';

                // Sort rows
                rows.sort((a, b) => {
                    let aVal = a.cells[colIndex].textContent.trim();
                    let bVal = b.cells[colIndex].textContent.trim();

                    // Try numeric comparison (remove R$, spaces, dots for thousands)
                    const aNum = parseFloat(aVal.replace(/[R$\s.]/g, '').replace(',', '.'));
                    const bNum = parseFloat(bVal.replace(/[R$\s.]/g, '').replace(',', '.'));

                    if (!isNaN(aNum) && !isNaN(bNum)) {
                        return newDir === 'asc' ? aNum - bNum : bNum - aNum;
                    }

                    // Date comparison (dd/mm/yyyy)
                    const dateRegex = /^(\d{2})\/(\d{2})\/(\d{4})$/;
                    const aDate = aVal.match(dateRegex);
                    const bDate = bVal.match(dateRegex);
                    if (aDate && bDate) {
                        const aD = new Date(aDate[3], aDate[2] - 1, aDate[1]);
                        const bD = new Date(bDate[3], bDate[2] - 1, bDate[1]);
                        return newDir === 'asc' ? aD - bD : bD - aD;
                    }

                    // String comparison
                    return newDir === 'asc'
                        ? aVal.localeCompare(bVal, 'pt-BR')
                        : bVal.localeCompare(aVal, 'pt-BR');
                });

                // Re-append sorted rows
                rows.forEach(row => tbody.appendChild(row));
                if (totalRow) tbody.appendChild(totalRow);
            });
        });
    });
});


// ==================== CONFIRM DELETE ====================

function confirmDelete(name) {
    return confirm('Tem certeza que deseja excluir "' + name + '"?\n\nEsta ação não pode ser desfeita.');
}
